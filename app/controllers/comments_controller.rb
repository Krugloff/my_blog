#encoding: utf-8

class CommentsController < ApplicationController
  before_filter :require_user,
    except: "index"
  before_filter :require_owner,
    except: %w(create index)

  def index
    @article = Article.find( params[:article_id] )
    @comments = @article.comments

    _respond_to_ajax
  end

  def create
    @comment = Comment.new( params[:comment] )
    @comment.article = Article.find( params[:article_id] )
    @comment.user = @user

    _render_errors unless @comment.save
    _redirect
  end

  def update
    _render_errors unless @comment.update_attributes( params[:comment] )
    _redirect
  end

  def destroy
    @comment.destroy
    _redirect
  end

  private

    def require_owner
      @comment = Comment.find( params[:id] )

      unless ( @user.owner? @comment ) || _me?
        flash.alert = ["You can't edit this comment"]
        _redirect
      end
    end

    def _redirect
      redirect_to article_comments_path( params[:article_id] )
    end

    def _render_errors
      flash.alert = @comment.errors.full_messages
    end
end
