# require 'test_helper'

class UserTest < ActiveSupport::TestCase
  models :users

  test 'create' do
    assert users(:admin).persisted?
    assert users(:client).persisted?
  end

  test 'name must be presence' do
    assert users(:no_name).invalid?
  end

  test 'owner' do
    models :articles, :accounts

    assert users(:admin).owner? articles(:valid)
    assert !users(:client).owner?( articles :valid )
  end

  test 'me' do
    models :accounts

    assert users(:admin).me?
    assert !users(:client).me?
  end
end
