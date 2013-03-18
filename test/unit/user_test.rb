#encoding: utf-8

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  models :users

  test "create" do
    ingots('users')
    assert User.create users('valid'), without_protection: true
  end

  test "find" do
    assert User.find users('valid').id
  end

  test "update" do
    assert users('valid').update_attribute( :name, "Mihael" )
  end

  test "destroy" do
    users('valid').destroy
    assert User.where( id: users('valid').id ).empty?
  end

  test "name: must be presence" do
    assert users('no_name').invalid?
  end
end
