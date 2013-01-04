#encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def search_user
    @user = User.find(session[:user_id])

    rescue ::ActiveRecord::RecordNotFound
      flash[:error] = "Требуется вход в систему."
      redirect_to root_path
  end
end
