#encoding: utf-8

class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    account_hash = auth_hash.slice :uid, :provider
    user_name = auth_hash[:info][:nickname] || auth_hash[:info][:name]

    @account = Account.where(account_hash).first

    if @account
      ( @user = @account.user ).update_attribute :name, user_name
    else
      @user = User.create!(name: user_name)
      @user.accounts.new(account_hash).save!
    end

    session[:user_id] = @user.id
    render 'users/show'

    rescue
      @user.try(:delete)
      flash.alert = ["You don't login"]
      redirect_to new_session_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def new
    @title = 'Login'
  end
end

