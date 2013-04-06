class CommentsController < ApplicationController
  before_filter :require_user,
    except: "index"

  before_filter :require_owner,
    except: %w( create index new )

  def create
    @comment = Comment.new( params[:comment] )
    @comment.article = @article ||= Article.find( params[:article_id] )
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
      format.js { head :accepted }
    end
  end

  def index
    # For handled history.
    @article = @article.try(:id) == params[:article_id] ?
      @article : Article.find( params[:article_id] )

    # For delete nested comments without changed data base.
    @comments = @article.comments.to_ary
    @comment  = Comment.new
    @title    = 'Comments'

    respond_to_xhr_for_nav
  end

  def new
    @article ||= Article.find( params[:article_id] )
    @parent_id = params[:parent_id]
    @comment  = Comment.new
    @title    = 'Reply to comment'
  end

  private

    def require_owner
      @comment = Comment.find( params[:id] )

      unless ( @user.owner? @comment ) || me?
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
