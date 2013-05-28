class UsersController < ApplicationController
  def show
    @title = @user.name
    @accounts = @user.accounts
    respond_to_xhr_for_nav
  end

  def update
    @user.update_attribute( :email, params[:user][:email] ) ||
    flash.alert = ['Not Updated']
    redirect_to user_path
  end

  def destroy
    @user.accounts.destroy_all
    reset_session
    redirect_to new_session_path
  end

  def edit
    @title = 'Edit user'
    respond_to_xhr_for_nav
  end
end
