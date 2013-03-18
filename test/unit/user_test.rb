#encoding: utf-8

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  models :users

  test "create" do
    ingots('users')
    assert User.create users('admin'), without_protection: true
  end

  test "find" do
    assert User.find users('admin').id
  end

  test "update" do
    assert users('admin').update_attribute( :name, "Mihael" )
  end

  test "destroy" do
    users('admin').destroy
    assert User.where( id: users('admin').id ).empty?
  end

  test "name: must be presence" do
    assert users('no_name').invalid?
  end

  test 'owner' do
    models 'articles', 'accounts'

    assert users('admin').owner? articles('valid')
    assert !users('client').owner?( articles 'valid' )
  end

  test 'me' do
    models 'accounts'

    assert users('admin').me?
    assert !users('client').me?
  end
end
