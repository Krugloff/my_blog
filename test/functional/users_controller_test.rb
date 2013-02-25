require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  models 'users'

  test "create" do
    ingots 'users'

    assert_difference( 'User.count', 1 ) { _post users('valid') }
    assert_response :redirect
    assert_redirected_to user_path
  end

  test "create: save error" do
    ingots 'users'

    assert_no_difference( 'User.count' ) {_post users('small_name')}
    assert flash.alert
    assert_response :redirect
    assert_redirected_to new_user_path
  end

  test "show" do
    login_as users('valid')
    get :show

    assert assigns(:user)
    assert_response :success
    assert_template 'show'
  end

  test "show: user not found" do
    get :show

    assert flash.alert
    assert_response :redirect
    assert_redirected_to new_session_path
  end

  test "update" do
    login_as users('valid')
    _put name: "Mike"

    assert assigns(:user)
    assert_response :redirect
    assert_redirected_to user_path
  end

  test "update: save error" do
    login_as users('valid')
    _put name: "?" * 257

    assert flash.alert
    assert_response :redirect
    assert_redirected_to edit_user_path
  end

  test "destroy" do
    login_as users('valid')

    assert_difference( 'User.count', -1 ) { delete :destroy }
    assert_response :redirect
    assert_redirected_to new_user_path
  end

  test "new" do
    get :new

    assert_response :success
    assert_template 'new'
  end

  test "edit" do
    login_as users('valid')
    get :edit

    assert assigns(:user)
    assert_response :success
    assert_template 'edit'
  end

  private

    def _post(params)
      post :create,
        user: params
    end

    def _put(params)
      put :update,
        user: params
    end
end
