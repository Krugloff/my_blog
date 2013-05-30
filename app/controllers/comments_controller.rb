class CommentsController < ApplicationController
  before_filter only: %i(update destroy) do
    @comment = Comment.find params[:id]
  end

  def create
    @comment = Comment.new params[:comment]
    @comment.article = @article ||= Article.find( params[:article_id] )
    @comment.user = @user

    if request.xhr?
      @comment.save ? render_comment : render_alerts
    else
      @comment.save || _save_errors
      _redirect
    end
  end

  def update
    @comment.update_attributes(params[:comment]) || _save_errors
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

    respond_to_xhr_for_nav
  end

  def new
    @article ||= Article.find params[:article_id]
    @parent_id = params[:parent_id]
    @comment  = Comment.new
  end

  private

    def _redirect(alert = [])
      redirect_to article_comments_path(params[:article_id]), alert: alert
    end

    def _save_errors
      flash.alert = @comment.errors.full_messages
    end
end
