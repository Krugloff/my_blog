#encoding: utf-8

class CommentsController < ApplicationController
  before_filter :require_authentication,
    except: "index"
  before_filter :require_owner,
    except: %w(create index)

  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments

    rescue ::ActiveRecord::RecordNotFound
      render( "public/404", layout: false, status: 404 )
  end

  def create
    comment = Comment.new(params[:comment])
    comment.article_id = params[:article_id]
    comment.user = @user

    flash[:errors] = comment.errors.full_messages unless comment.save
    _redirect
  end

  def update
    @comment.update_attributes( params[:comment] )
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
        flash[:alert] = ['Вы не можете изменить этот комментарий.']
        _redirect
      end
    end

    def _redirect
      redirect_to article_path( params[:article_id] )
    end
end
