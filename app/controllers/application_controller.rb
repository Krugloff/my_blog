class ApplicationController < ActionController::Base
  use Rack::Locale

  # Authorization.
  extend Cando
  helper Cando::Authorization::Helper
  include AuthorizationHelper

  rescue_from Cando::Errors::AccessDenied do |exc|
    redirect_to new_session_path, alert: [exc.message]
  end

  include Ajax
  include ActionView::Helpers::SanitizeHelper

  before_filter :last_articles, :current_user, :current_article

  before_filter :current_title, only: %i( index new edit preview )

  protect_from_forgery

  def last_articles
    @last_articles = Article.last(7) if Article.many?
  end

  def current_user
    @user ||= User.where( id: session[:user_id] ).first
  end

  def current_article
    if @article.try(:id) != cookies[:article_id]
      @article = Article.where( id: cookies[:article_id] ).first
    end
  end

  def current_title
    @title = I18n.t( "#{controller_name}.#{action_name}.title" )
  end
end
