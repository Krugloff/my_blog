# require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  models :users, :accounts

  test 'show' do
    login_as :admin
    get :show

    _asserts_for_show
  end

  test 'ajax show' do
    login_as :admin
    xhr :get, :show

    _asserts_for_show
  end

  test 'update' do
    login_as :admin

    put :update, user: {email: 'mr.krugloff@gmail.com'}

    assert_nil flash.alert
    assert_redirected_to user_path
  end

  test 'destroy' do
    login_as :admin

    assert_no_difference('User.count') { delete :destroy }
    assert_nil session[:user_id]
    assert_response :redirect
    assert_redirected_to new_session_path
  end

  test 'edit' do
    login_as :admin

    get :edit
    assert_template :edit
  end

  test 'ajax edit' do
    login_as :admin

    xhr :get, :edit
    assert_template :edit
  end

  private

    def _asserts_for_show
      assert assigns  :user
      assert assigns  :title
      assert assigns  :accounts
      assert_response :success
      assert_template :show
      assert_template 'accounts/index'
      assert_template 'accounts/new'
    end
end
