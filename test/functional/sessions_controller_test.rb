require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "create: old user" do
    models 'users', 'accounts'
    _prepare_request accounts('valid').attributes, users('valid').attributes

    assert_no_difference('User.count') { get :create }

    assert session[:user_id]
    assert_response :redirect
    assert_redirected_to user_path
  end

  test "create: new user" do
    ingots 'accounts', 'users'
    _prepare_request accounts('valid'), users('valid')

    assert_difference( 'User.count', 1 ) { get :create }

    assert session[:user_id]
    assert_response :redirect
    assert_redirected_to user_path
  end

  test "create: error" do
    ingots 'accounts', 'users'

    assert_no_difference('User.count') { get :create }

    assert_nil session[:user_id]
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

    assert assigns(:title)
    assert_response :success
    assert_template :new
  end

  private

    def _prepare_request(account_hash, user_hash)
      request.env['omniauth.auth'] = account_hash
        .slice(:uid, :provider)
        .merge info: user_hash.slice(:name)
    end
end
