class UsersController < ApplicationController
  before_filter :login?,
    only: [ "show", "update", "destroy", "edit" ]

  def create
    @user = User.new params[:user]

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path
      # TODO?: session_controller
      # redirect_to "sessions#create",
      #   user: { name: params[:user][:name],
      #           password: params[:user][:password] }
    else
      flash[:error] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def show
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to user_path
    else
      flash[:error] = @user.errors.full_messages
      redirect_to edit_user_path
    end
  end

  def destroy
    User.destroy @user.id
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def edit
  end
end
