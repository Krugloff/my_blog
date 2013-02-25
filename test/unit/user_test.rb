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
    assert users('blank_name').invalid?
  end

  test "name: 3 <= length <= 42" do
    assert users('big_name').invalid?
    assert users('small_name').invalid?
  end

  test "name: must be uniq" do
    assert users('not_uniq').invalid?
  end

  test 'name: format' do
    users('valid').name = "O'Konnel"
    assert users('valid').valid?, users('valid').name

    users('valid').name = 'Mr. Dreams'
    assert users('valid').valid?, users('valid').name

    users('valid').name = 'Симпсон'
    assert users('valid').valid?, users('valid').name

    users('valid').name = 'Mr, Dreams'
    assert users('valid').invalid?, users('valid').name

    users('valid').name = ';DROP DATABASE where user.*'
    assert users('valid').invalid?, users('valid').name

    users('valid').name = "<<\n>>"
    assert users('valid').invalid?, users('valid').name

    users('valid').name = '>>>>'
    assert users('valid').invalid?, users('valid').name
  end

  test "password: must be presence" do
    assert users('blank_password').invalid?
  end
end
