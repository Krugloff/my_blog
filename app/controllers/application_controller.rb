#encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter do
    @last_articles = Article.last(7) if Article.many?
    @user = User.where(id: session[:user_id]).last
  end

  private

    def require_authentication
      unless @user
        redirect_to root_path,
          alert: 'Для этого действия требуется вход в систему.'
      end
    end

    def _me?
      @user.name == 'Krugloff'
    end

    def require_authorization
      unless _me?
        redirect_to root_path, alert: 'Вы не можете выполнить это действие.'
      end
    end
end
