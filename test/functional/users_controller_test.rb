require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "create" do
    assert_difference( 'User.count', 1 ) do
      post :create,
        user: { name: "Mike",
                password: "yes",
                password_confirmation: "yes" }
    end

    assert_response :redirect
    assert_redirected_to user_path
  end

  test "create: save error" do
    assert_no_difference( 'User.count' ) do
      post :create,
        user: { name: "John" }
    end

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

    assert_response :redirect
    assert_redirected_to root_path
  end

  test "update" do
    login_as @user

    put :update,
      user: { name: "Mike" }

    assert assigns(:user)

    assert_response :redirect
    assert_redirected_to user_path
  end

  test "update: save error" do
    login_as @user

    put :update,
      user: { name: "?" * 257 }

    assert_response :redirect
    assert_redirected_to edit_user_path
  end

  test "destroy" do
    login_as @user

    assert_difference( 'User.count', -1 ) do
      delete :destroy
    end

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
end
