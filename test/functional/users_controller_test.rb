# require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  models 'users'

  test "show" do
    login_as users('admin')
    get :show

    _asserts_for_show
  end

  test "ajax show" do
    login_as users('admin')
    xhr :get, :show

    _asserts_for_show
  end

  test "show: user not found" do
    get :show

    assert flash.alert
    assert_response :redirect
    assert_redirected_to new_session_path
  end

  test "destroy" do
    login_as users('admin')

    assert_no_difference('User.count') { delete :destroy }
    assert_nil session[:user_id]
    assert_response :redirect
    assert_redirected_to new_session_path
  end

  private

    def _asserts_for_show
      assert assigns(:user)
      assert assigns(:title)
      assert_response :success
      assert_template 'show'
    end
end
