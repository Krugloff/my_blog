class ApplicationController < ActionController::Base
  include Ajax
  include ActionView::Helpers::SanitizeHelper

  # I want move it to authorization.rb but don't know as.
  helper Cando::Authorization::Helper
  include AuthorizationHelper

  use Rack::Locale

  protect_from_forgery

  before_filter do
    @last_articles = Article.last(7) if Article.many?
    @user ||= User.where( id: session[:user_id] ).first

    if @article.try(:id) != cookies[:article_id]
      @article = Article.where( id: cookies[:article_id] ).first
    end
  end
end
