#encoding: utf-8

class ArticlesController < ApplicationController
  before_filter :login?, except: %w( show index )
  before_filter :authorization, only: %w( update destroy edit )

  def create
    @article = @user.articles.new params[:article]

    if @article.save
      redirect_to article_path(@article)
    else
      flash[:error] = @article.errors.full_messages
      redirect_to new_article_path
    end
  end

  def show
    if @article = Article.find_by_id(params[:id])
      @comments = @article.comments
    else
      render "public/404", status: 404
    end
  end

  def update
    if @article.update_attributes params[:article]
      redirect_to @article
    else
      flash[:error] = @article.errors.full_messages
      redirect_to edit_article_path(@article.id)
    end
  end

  def destroy
    Article.destroy params[:id]
    redirect_to articles_path
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  private

  def authorization
    @article = @user.articles.find_by_id(params[:id])

    unless @article
      flash[:error] = "Вы не можете изменить эту статью."
      redirect_to article_path(params[:id])
    end
  end
end
