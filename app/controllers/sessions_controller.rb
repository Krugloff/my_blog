#encoding: utf-8

class SessionsController < ApplicationController
  def create
    user = User.find_by_name(params[:user][:name])
      .try(:authenticate, params[:user][:password])

    if user
      session[:user_id] = user.id
      redirect_to user_path
    else
      flash[:error] = "Проверьте правильность введенных данных."
      redirect_to root_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
