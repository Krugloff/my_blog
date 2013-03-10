#encoding: utf-8

class CommentsController < ApplicationController
  before_filter :require_user,
    except: "index"
  before_filter :require_owner,
    except: %w(create index)

  def index
    @article = Article.find( params[:article_id] )
    @comments = @article.comments

    respond_to_xhr_with_change_history
  end

  def create
    @comment = Comment.new( params[:comment] )
    @article = @comment.article = Article.find( params[:article_id] )
    @comment.user = @user

    respond_to do |format|
      format.html do
        _save_errors unless @comment.save
        _redirect
      end

      format.js do
        @comment.save ? add_new_comment : add_alerts
      end
    end
  end

  def update
    _save_errors unless @comment.update_attributes( params[:comment] )
    _redirect
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { _redirect }
      format.js do
        @article = @comment.article
        script =  "$('#comment_#{@comment.id}').parent().remove();" +
                  change_comments_count
        render js: script
      end
    end
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

    def _save_errors
      flash.alert = @comment.errors.full_messages
    end
end
