class ArticlesController < ApplicationController
  def create
    @article = Article.create params[:article]
    if @article.save
      redirect_to article_path(@article)
    else
      redirect_to new_article_path  
    end    
  end

  def show
    @article = Article.find params[:id]
    @comments = @article.comments
  end

  def update
    @article = Article.find params[:id]
    
    if @article.update_attributes params[:article]
      redirect_to article_path(@article.id)
    else
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
