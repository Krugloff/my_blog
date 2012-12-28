class CommentsController < ApplicationController
  def create
    article = Article.find params[:article_id]
    comment = Comment.new(params[:comment])

    article.comments << comment
    redirect_to article_path(article)
  end

  def update
    article = Article.find params[:article_id]
    comment = article.comments.find params[:id]
    comment.update_attributes params[:comment]

    redirect_to article_path(article)
  end

  def destroy
    Comment.destroy params[:id]
    redirect_to article_path(params[:article_id])
  end
end
