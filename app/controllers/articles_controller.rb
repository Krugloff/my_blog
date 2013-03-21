#encoding: utf-8

class ArticlesController < ApplicationController
  before_filter :require_user,
    except: %w( show index last )

  before_filter :require_owner,
    only: %w( update destroy edit )

  before_filter :require_me,
    only: %w( create new )

  before_filter only: %w( create update ) do
    params[:article][:title] = strip_tags params[:article][:title]
  end

  def create
    @article = @user.articles.new( params[:article] )
    @article.save ? redirect_to(@article) : _errors_to(new_article_path)
  end

  def show
    @article = Article.find(params[:id])
    @title = @article.title
    cookies[:article_id] = params[:id] if cookies[:article_id] != params[:id]
    respond_to_xhr_for_nav
  end

  def update
    if @article.update_attributes( params[:article] )
      redirect_to @article
    else
      _errors_to edit_article_path(@article.id)
    end
  end

  def destroy
    @article.destroy
    cookies.delete :article_id
    redirect_to articles_path
  end

  def index
    @title = 'Articles'

    month = params['month'].to_i
    year  = params['year'].to_i
    @date = ( Date.new year, month rescue Date.current.beginning_of_month )

    @articles = Article.where created_at: @date..@date.end_of_month
    flash.now[:alert] = ['Articles not found'] if @articles.empty?

    respond_to_xhr_for_nav { add_tooltip }
  end

  def new
    @article = Article.new
    @title = 'New article'
    respond_to_xhr_for_nav
  end

  def edit
    @title = 'Edit article'
    respond_to_xhr_for_nav
  end

  def last
    @article = Article.last
    redirect_to @article || articles_path
  end

  private

    def require_owner
      @article = Article.find( params[:id] )

      unless ( @user.owner? @article ) || me?
        flash.alert = ["You can't edit this article"]
        redirect_to article_path( params[:id] )
      end
    end

    def _errors_to(path)
      redirect_to path, alert: @article.errors.full_messages
    end
end
