class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']

    @account =  Account.find_with_omniauth(auth_hash) ||
                Account.build_with_omniauth(auth_hash)

    if @account.persisted?
      ( @user = @account.user ).update_attribute :name, @account.name
    else
      @user = session[:user_id] ?
              User.find(session[:user_id]) :
              User.create!(name: @account.name)

      @user.accounts << @account
    end

    session[:user_id] ||= @user.id
    redirect_to user_path

    rescue
      @user.try(:delete)
      flash.alert = [ I18n.t( 'alerts.not_login' ) ]
      redirect_to new_session_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def new
  end
end

