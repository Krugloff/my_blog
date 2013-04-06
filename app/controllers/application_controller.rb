class ApplicationController < ActionController::Base
  include Ajax
  include ActionView::Helpers::SanitizeHelper

  protect_from_forgery

  before_filter do
    @last_articles = Article.last(7) if Article.many?
    @user ||= User.where( id: session[:user_id] ).first

    if @article.try(:id) != cookies[:article_id]
      @article = Article.where( id: cookies[:article_id] ).first
    end
  end

  helper_method :me?

  private

    def require_user
      unless @user
        redirect_to new_session_path, alert: ['You should be login']
      end
    end

    def require_me
      redirect_to new_session_path, alert: ["You can't do it"] unless me?
    end

    def me?
      @user.try :me?
    end
end
