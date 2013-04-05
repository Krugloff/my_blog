# require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  models :comments

  test 'create valid' do
    assert comments('valid').valid?
    assert comments('child').valid?
  end

  test 'article must be presence' do
    assert comments('no_article').invalid?
  end

  test 'user must be presence' do
    assert comments('new').invalid?
  end

  test 'body must be presence' do
    assert comments('blank_body').invalid?
  end

  test 'body as html' do
    assert_not_equal comments('valid').body, comments('valid').body_as_html
    assert_no_match %r|```ruby|, comments('valid').body_as_html
    assert_same comments('valid').body_as_html, comments('valid').body_as_html
  end

  test 'body as html cache' do
    old_value = comments('valid').body_as_html
    comments('valid').update_attribute :body, 'Hello!' # clear cache.
    new_value = comments('valid').body_as_html

    assert_not_same old_value, new_value
  end
end
