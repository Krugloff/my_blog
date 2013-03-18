class UsersController < ApplicationController
  before_filter :require_user

  def show
    @title = @user.name
    respond_to_xhr_for_nav
  end

  def destroy
    @user.accounts.destroy_all
    reset_session
    redirect_to new_session_path
  end
end
