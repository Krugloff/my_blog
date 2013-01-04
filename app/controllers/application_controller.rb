#encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def login?
    unless @user = User.find_by_id(session[:user_id])
      flash[:error] = "Требуется вход в систему."
      redirect_to root_path
    end
  end
end
