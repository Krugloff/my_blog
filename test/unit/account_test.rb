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

  test 'name must be presence' do
    assert accounts(:no_name).invalid?
  end

  test 'find with omniauth' do
    auth_hash =
      accounts(:admin).attributes.slice(:uid, :provider, :name).stringify_keys

    assert Account.find_with_omniauth(auth_hash)
  end

  test 'create with omniauth' do
    models :users
    ingots :accounts
    auth_hash = accounts(:new)
                  .except(:name)
                  .merge(info: { 'name' => 'Krugloff' })
                  .stringify_keys

    assert_difference 'Account.count', 1 do
      account = Account.build_with_omniauth(auth_hash)
      account.user = users :admin
      account.save
    end
  end
end
