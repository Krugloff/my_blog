require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  models :accounts

  test 'create' do
    assert accounts('admin').persisted?
    assert accounts('client').persisted?
  end

  test 'provider must be presence' do
    assert accounts('blank_provider').invalid?
  end

  test 'user must be presence' do
    assert accounts('new').invalid?
  end

  test 'uid must be presence' do
    assert accounts('no_uid').invalid?
  end
end
