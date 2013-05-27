require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  test 'destroy' do
    models :users, :accounts

    login_as :admin

    assert_difference 'Account.count', -1 do
      delete :destroy, id: accounts(:admin).id
    end

    assert_response :redirect
    assert_redirected_to user_path
  end
end
