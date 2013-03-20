#encoding: utf-8

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  models :comments

  test "create" do
    ingots 'comments'
    assert Comment.create comments('valid'), without_protection: true
  end

  test "find" do
    assert Comment.find comments('valid')
  end

  test "update" do
    assert comments('valid').update_attribute( :title, "Приветствие" )
  end

  test "destroy" do
    comments('valid').destroy
    assert Comment.where( id: comments('valid').id ).empty?
  end

  test "body: must be presence" do
    assert comments('blank_body').invalid?
  end

  test 'body_as_html' do
    assert_no_match %r|```ruby|, comments('valid').body_as_html
    assert comments('valid').instance_variable_get '@html'
    assert_not_equal comments('valid').body, comments('valid').body_as_html
    assert_same comments('valid').body_as_html, comments('valid').body_as_html
  end

  test 'body_as_html: cache' do
    old_value = comments('valid').body_as_html
    comments('valid').update_attribute :title, 'Hello!' # clear cache.
    new_value = comments('valid').body_as_html
    assert_not_same old_value, new_value
  end

  test "title: lenght <= 42" do
    assert comments('big_title').invalid?
  end

  test "article: must be presence" do
    assert comments('no_article').invalid?
  end

  test "user: must be presence" do
    assert comments('no_user').invalid?
  end
end
