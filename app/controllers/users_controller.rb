class UsersController < ApplicationController
  authorize { for_client *%i(show destroy edit) }

  def show
    @title = @user.name
    @accounts = @user.accounts
    respond_to_xhr_for_nav
  end

  def update
    @user.update_attribute( :email, params[:user][:email] ) ||
    flash.alert = [ I18n.t( 'alerts.not_updated' ) ]
    redirect_to user_path
  end

  def destroy
    @user.accounts.destroy_all
    reset_session
    redirect_to new_session_path
  end

  def edit
    respond_to_xhr_for_nav
  end
end
