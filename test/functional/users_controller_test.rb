require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "create" do
    @user_attr = { name: "Mike",
                   password: "yes",
                   password_confirmation: "yes" }

    assert_difference( 'User.count', 1 ) {_post}
    assert_response :redirect
    assert_redirected_to user_path
  end

  test "create: save error" do
    @user_attr = { name: "John" }

    assert_no_difference( 'User.count' ) {_post}
    assert flash.alert
    assert_response :redirect
    assert_redirected_to new_user_path
  end

  test "show" do
    login_as @user
    get :show

    assert assigns(:user)
    assert_response :success
    assert_template 'show'
  end

  test "show: user not found" do
    get :show

    assert flash.alert
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "update" do
    login_as @user
    @user_attr = { name: "Mike" }
    _put

    assert assigns(:user)
    assert_response :redirect
    assert_redirected_to user_path
  end

  test "update: save error" do
    login_as @user
    @user_attr = { name: "?" * 257 }
    _put

    assert flash.alert
    assert_response :redirect
    assert_redirected_to edit_user_path
  end

  test "destroy" do
    login_as @user

    assert_difference( 'User.count', -1 ) {delete :destroy}
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "new" do
    get :new

    assert_response :success
    assert_template 'new'
  end

  test "edit" do
    login_as @user
    get :edit

    assert assigns(:user)
    assert_response :success
    assert_template 'edit'
  end

  private

    def _post
      post :create,
        user: @user_attr
    end

    def _put
      put :update,
        user: @user_attr
    end
end
