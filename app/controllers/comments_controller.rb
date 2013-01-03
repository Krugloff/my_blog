#encoding: utf-8

class CommentsController < ApplicationController
  before_filter :login?
  before_filter :authorization, except: "create"

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

  private

  def authorization
    unless @comment = @user.comments.find_by_id(params[:id])
      flash[:error] = "Вы не можете изменить этот комментарий"
      redirect_to article_path(params[:article_id])
    end
  end
end
