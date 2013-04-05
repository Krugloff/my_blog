# require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  models :articles

  test 'create' do
    assert articles('valid').valid?
  end

  test 'user must be presence' do
    assert articles('new').invalid?
  end

  test 'title must be presence' do
    assert articles('blank_title').invalid?
  end

  test 'title lenght <= 42' do
    assert articles('big_title').invalid?
  end

  test 'body must be presence' do
    assert articles('blank_body').invalid?
  end

  test 'body as html' do
    assert_not_equal articles('valid').body, articles('valid').body_as_html
    assert_no_match %r|```ruby|, articles('valid').body_as_html
    assert_same articles('valid').body_as_html, articles('valid').body_as_html
  end

  test 'body as html: cache' do
    old_value = articles('valid').body_as_html
    articles('valid').update_attribute :title, 'Hello!' # clear cache.
    new_value = articles('valid').body_as_html

    assert_not_same old_value, new_value
  end
end
