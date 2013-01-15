class UsersController < ApplicationController
  before_filter :require_authentication,
    except: %w( create new )

  def create
    @user = User.new( params[:user] )

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path
    else
      _errors_to(new_user_path)
    end
  end

  def show
  end

  def update
    if @user.update_attributes( params[:user] )
      redirect_to user_path
    else
      _errors_to(edit_user_path)
    end
  end

  def destroy
    @user.destroy
    redirect_to new_user_path
  end

  def new
    @user = User.new
  end

  def edit
  end

  private

    def _errors_to(path)
      redirect_to path, alert: @user.errors.full_messages
    end
end
