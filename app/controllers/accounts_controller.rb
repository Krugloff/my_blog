class AccountsController < ApplicationController
  def destroy
    @user.accounts.destroy params[:id]

    rescue ActiveRecord::RecordNotFound
      flash.alert = [ I18n.t( 'alerts.for_owner' ) ]
    ensure
      redirect_to user_path
  end
end
