require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
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

    assert_response :redirect
    assert_redirected_to root_path
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
