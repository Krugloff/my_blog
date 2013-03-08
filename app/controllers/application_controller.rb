#encoding: utf-8

class ApplicationController < ActionController::Base
  include Blinks

  protect_from_forgery

  before_filter do
    @last_articles = Article.last(7) if Article.many?
    @user ||= User.where(id: session[:user_id]).first
  end

  private

    def require_user
      unless @user
        redirect_to new_session_path, alert: ['You should be login']
      end
    end

    def require_me
      redirect_to root_path, alert: ["You can't do it"] unless _me?
    end

    def _me?
      @user.name == 'Krugloff'
    end

    def _respond_to_xhr_with_change_history(*template)
      with = yield if block_given?
      respond_to_xhr(*template, {html: '.blinks'}) do
        change_history + with.to_s
      end
    end

    def _render_alert
      html = render_to_string partial: "layouts/alert",
                              collection: flash[:alert]
      "$('.content').prepend('#{escape_javascript html}');"
    end
end
