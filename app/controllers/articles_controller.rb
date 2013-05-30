class ArticlesController < ApplicationController
  before_filter only: %i( create update ) do
    params[:article][:title] = strip_tags params[:article][:title]
  end

  before_filter only: %i(update destroy edit show) do
    @article = Article.find params[:id]
  end

  def create
    @article = @user.articles.new( params[:article] )
    @article.save ? redirect_to(@article) : _errors_to(new_article_path)
  end

  def show
    @title = @article.title
    cookies[:article_id] = params[:id] if cookies[:article_id] != params[:id]
    respond_to_xhr_for_nav
  end

  def update
    if @article.update_attributes params[:article]
      redirect_to @article
    else
      _errors_to edit_article_path @article
    end
  end

  def destroy
    @article.destroy
    cookies.delete :article_id
    redirect_to articles_path
  end

  def index
    month = params['month'].to_i
    year  = params['year'].to_i
    @date = ( Date.new year, month rescue Date.current.beginning_of_month )

    @articles = Article.where created_at: @date..@date.end_of_month
    flash.now[:alert] = [ I18n.t( 'alerts.not_articles' ) ] if @articles.empty?

    respond_to_xhr_for_nav
  end

  def new
    @article = Article.new
    respond_to_xhr_for_nav
  end

  def edit
    respond_to_xhr_for_nav
  end

  def last
    @article = Article.last
    redirect_to @article || articles_path
  end

  private

    def _errors_to(path)
      redirect_to path, alert: @article.errors.full_messages
    end
end
