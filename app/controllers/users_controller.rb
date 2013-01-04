class UsersController < ApplicationController
  before_filter :search_user,
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
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def edit
  end

  private

  def _errors_to(path)
    flash[:errors] = @user.errors.full_messages
    redirect_to path
  end
end
