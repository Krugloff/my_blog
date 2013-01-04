#encoding: utf-8

class ArticlesController < ApplicationController
  before_filter :login?,
    except: %w( show index )

  before_filter :authorization,
    only: %w( update destroy edit )

  def create
    @article = @user.articles.new(params[:article])

    @article.save ? redirect_to(@article) : _errors_to(new_article_path)
  end

  def show
    @article = Article.find_by_id(params[:id])
    render( "public/404", status: 404 ) unless @article
  end

  def update
    if @article.update_attributes params[:article]
      redirect_to @article
    else
      _errors_to edit_article_path(@article.id)
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
    unless @article = @user.articles.find_by_id(params[:id])
      flash[:error] = "Вы не можете изменить эту статью."
      redirect_to article_path(params[:id])
    end
  end

  def _errors_to(path)
    flash[:errors] = @article.errors.full_messages
    redirect_to path
  end
end
