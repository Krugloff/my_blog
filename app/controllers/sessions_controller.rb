#encoding: utf-8

class SessionsController < ApplicationController
  def create
    @user = User.find_by_name(params[:name])
      .try(:authenticate, params[:password])

    if @user
      session[:user_id] = @user.id
    else
      flash.alert = ['Incorrect name or password']
    end

    redirect_to @user ? user_path : new_session_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def new
    @title = 'Login'
  end
end
