class UsersController < ApplicationController
  def show
    @title = @user.name
    @accounts = @user.accounts
    respond_to_xhr_for_nav
  end

  def destroy
    @user.accounts.destroy_all
    reset_session
    redirect_to new_session_path
  end
end
