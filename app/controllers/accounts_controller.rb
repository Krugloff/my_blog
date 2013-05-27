class AccountsController < ApplicationController
  def destroy
    @user.accounts.destroy params[:id]

    rescue ActiveRecord::RecordNotFound
      flash.alert = ['You should be owner']
    ensure
      redirect_to user_path
  end
end
