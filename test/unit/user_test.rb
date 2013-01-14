#encoding: utf-8

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create" do
    assert @user.save
  end

  test "find" do
    assert User.find(@user.id)
  end

  test "update" do
    assert @user.update_attribute( :name, "Mihael" )
  end

  test "destroy" do
    @user.destroy
    assert User.where(id: @user.id).empty?
  end

  test "name: must be presence" do
    @user.name = ""
    assert @user.invalid?
  end

  test "name: 3 <= length <= 42" do
    @user.name = "?" * 257
    assert @user.invalid?

    @user.name = 'xx'
    assert @user.invalid?
  end

  test "name: must be uniq" do
    user = User.new( name: "krugloFF",
                     password: "yes",
                     password_confirmation: "yes" )

    assert user.invalid?
  end

  test 'name: format' do
    @user.name = "O'Konnel"
    assert @user.valid?, @user.name

    @user.name = 'Mr. Dreams'
    assert @user.valid?, @user.name

    @user.name = 'Симпсон'
    assert @user.valid?, @user.name

    @user.name = 'Mr, Dreams'
    assert @user.invalid?, @user.name

    @user.name = ';DROP DATABASE where user.*'
    assert @user.invalid?, @user.name

    @user.name = "<<\n>>"
    assert @user.invalid?, @user.name

    @user.name = '>>>>'
    assert @user.invalid?, @user.name
  end

  test "password: must be presence" do
    @user.password = ""
    assert @user.invalid?
  end
end
