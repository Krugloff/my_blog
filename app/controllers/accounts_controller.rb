class AccountsController < ApplicationController
  def destroy
    @user.accounts.destroy params[:id]
    redirect_to user_path
  end
end
