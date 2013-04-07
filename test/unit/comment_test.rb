# require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  models :comments

  test 'create valid' do
    assert comments(:valid).valid?
    assert comments(:child).valid?
  end

  test 'delete parent' do
    assert_difference( 'Comment.count', -1 ) { comments(:valid).destroy }
    assert_nil comments(:child).reload.parent_id, comments(:child).inspect
  end

  test 'article must be presence' do
    assert comments(:no_article).invalid?
  end

  test 'user must be presence' do
    assert comments(:new).invalid?
  end

  test 'body must be presence' do
    assert comments(:blank_body).invalid?
  end

  test 'body as html' do
    comment = comments :valid

    assert_not_equal comment.body, comment.body_as_html
    assert_no_match %r|```ruby|, comment.body_as_html
    assert_same comment.body_as_html, comment.body_as_html
  end

  test 'body as html cache' do
    comment = comments :valid

    old_value = comment.body_as_html
    comment.update_attribute :body, 'Hello!' # clear cache.
    new_value = comment.body_as_html

    assert_not_same old_value, new_value
  end
end
