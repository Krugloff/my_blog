class ApplicationController < ActionController::Base
  include Ajax
  include ActionView::Helpers::SanitizeHelper
  include AuthorizationHelper

  protect_from_forgery

  before_filter do
    @last_articles = Article.last(7) if Article.many?
    @user ||= User.where( id: session[:user_id] ).first

    if @article.try(:id) != cookies[:article_id]
      @article = Article.where( id: cookies[:article_id] ).first
    end
  end
end
