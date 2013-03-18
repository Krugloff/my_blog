require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  models 'users'

  test "show" do
    login_as users('admin')
    get :show

    assert assigns(:user)
    assert assigns(:title)
    assert_response :success
    assert_template 'show'
  end

  test "ajax show" do
    login_as users('admin')
    xhr :get, :show

    assert assigns(:user)
    assert assigns(:title)
    assert_response :success
    assert_template 'show'
  end

  test "show: user not found" do
    get :show

    assert flash.alert
    assert_response :redirect
    assert_redirected_to new_session_path
  end

  test "destroy" do
    login_as users('admin')

    assert_difference( 'User.count', -1 ) { delete :destroy }
    assert_response :redirect
    assert_redirected_to new_session_path
  end
end
