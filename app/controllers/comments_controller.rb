class CommentsController < ApplicationController
  before_filter :login?

  def create
    comment = Comment.new(params[:comment])
    comment.article = Article.find params[:article_id]
    comment.user = @user

    flash[:errors] = comment.errors.full_messages unless comment.save

    redirect_to article_path(params[:article_id])
  end

  def update
    comment = Comment.find params[:id]
    comment.update_attributes params[:comment]

    redirect_to article_path(params[:article_id])
  end

  def destroy
    Comment.destroy params[:id]
    redirect_to article_path(params[:article_id])
  end
end
