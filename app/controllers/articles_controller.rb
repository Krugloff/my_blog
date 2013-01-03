class ArticlesController < ApplicationController
  before_filter :login?, except: %w( show index )

  def create
    @article = Article.create params[:article]
    @article.user = @user

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
    @article = Article.find params[:id]

    if @article.update_attributes params[:article]
      redirect_to article_path(@article.id)
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
    @article = Article.find params[:id]
  end
end
