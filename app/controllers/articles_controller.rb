#encoding: utf-8

class ArticlesController < ApplicationController
  before_filter :require_authentication,
    except: %w( show index )

  before_filter :require_owner,
    only: %w( update destroy edit )

  before_filter :require_authorization,
    only: 'create'

  def create
    @article = @user.articles.new( params[:article] )

    @article.save ? redirect_to(@article) : _errors_to(new_article_path)
  end

  def show
    @article = Article.find(params[:id])

    rescue ::ActiveRecord::RecordNotFound
      render( "public/404", status: 404 )
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

    def require_owner
      @article = Article.find( params[:id] )

      unless ( @user.owner? @article ) || _me?
        flash[:alert] = ['Вы не можете изменить эту статью.']
        redirect_to article_path( params[:id] )
      end
    end

    def _errors_to(path)
      redirect_to path, alert: @article.errors.full_messages
    end
end
