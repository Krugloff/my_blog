require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  models 'accounts'

  test "create" do
    ingots 'accounts'
    assert Account.create accounts('valid'), without_protection: true
  end

  test "find" do
    assert Account.find accounts('valid').id
  end

  test "update" do
    assert accounts('valid').update_attribute( :provider, "github" )
  end

  test "destroy" do
    accounts('valid').destroy
    assert Account.where( id: accounts('valid').id ).empty?
  end

  test "provider: must be presence" do
    assert accounts('blank_provider').invalid?
  end

  test "user: must be presence" do
    assert  accounts('no_user').invalid?
  end
end
