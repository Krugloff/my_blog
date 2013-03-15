class UsersController < ApplicationController
  before_filter :require_user

  def show
    @title = @user.name
    respond_to_xhr html: '.content'
  end

  def destroy
    @user.destroy
    redirect_to new_session_path
  end
end
