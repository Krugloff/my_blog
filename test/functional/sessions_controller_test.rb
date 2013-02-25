require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  models 'users'

  test "create" do
    post :create,
      name: "Krugloff", password: "a11ri9ht"

    assert session[:user_id]
    assert_response :redirect
    assert_redirected_to user_path
  end

  test "create: not authenticate" do
    post :create,
      name: "John", password: "no"

    assert flash.alert
    assert_response :redirect
    assert_redirected_to new_session_path
  end

  test "destroy" do
    delete :destroy

    assert_response :redirect
    assert_redirected_to root_path
  end

  test 'new' do
    get :new

    assert_response :success
    assert_template :new
  end
end
