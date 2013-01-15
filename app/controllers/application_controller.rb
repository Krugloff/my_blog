#encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter do
    @last_articles = Article.last(7) if Article.many?
    @user ||= User.where(id: session[:user_id]).first
  end

  private

    def require_authentication
      unless @user
        redirect_to new_session_path, alert: ['You should be login']
      end
    end

    def _me?
      @user.name == 'Krugloff'
    end

    def require_authorization
      redirect_to root_path, alert: ["You can't do it"] unless _me?
    end
end
