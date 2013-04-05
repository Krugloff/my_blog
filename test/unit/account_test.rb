require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  models :accounts

  test 'create' do
    assert accounts(:admin).valid?
    assert accounts(:client).valid?
  end

  test 'user must be presence' do
    assert accounts(:new).invalid?
  end

  test 'provider must be presence' do
    assert accounts(:blank_provider).invalid?
  end

  test 'uid must be presence' do
    assert accounts(:no_uid).invalid?
  end
end
