require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create" do
    assert @user.save
  end

  test "find" do
    assert_not_nil User.find_by_id(@user.id)
  end

  test "update" do
    assert @user.update_attribute( :name, "Mihael" )
  end

  test "destroy" do
    @user.destroy
    assert_nil User.find_by_id(@user.id)
  end

  test "name must be presence" do
    @user.name = ""
    assert @user.invalid?
  end

  test "name less or equal 42" do
    @user.name = "?" * 257
    assert @user.invalid?
  end

  test "name must be uniq" do
    user = User.new( name: "joHn",
                     password: "yes",
                     password_confirmation: "yes" )

    assert user.invalid?
  end

  test "password must be presence" do
    @user.password = ""
    assert @user.invalid?
  end
end
