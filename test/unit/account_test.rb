require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  models 'accounts'

  test "create" do
    ingots 'accounts'
    assert Account.create accounts('admin'), without_protection: true
  end

  test "find" do
    assert Account.find accounts('admin').id
  end

  test "update" do
    assert accounts('admin').update_attribute( :provider, "github" )
  end

  test "destroy" do
    accounts('admin').destroy
    assert Account.where( id: accounts('admin').id ).empty?
  end

  test "provider: must be presence" do
    assert accounts('blank_provider').invalid?
  end

  test "user: must be presence" do
    assert accounts('no_user').invalid?
  end

  test 'uid: must be presence' do
    assert accounts('no_uid').invalid?
  end
end
