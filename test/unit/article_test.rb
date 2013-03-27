# require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  models :articles

  test "create" do
    ingots 'articles'
    assert Article.create articles('valid'), without_protection: true
  end

  test "find" do
    assert Article.find articles('valid')
  end

  test "update" do
    assert articles('valid')
      .update_attribute( :title, "Welcome to my superblog!" )
  end

  test "destroy" do
    articles('valid').destroy
    assert Article.where( id: articles('valid').id ).empty?
  end

  test "title: must be presence" do
    assert articles('blank_title').invalid?
  end

  test "body: must be presence" do
    assert articles('blank_body').invalid?
  end

  test "title: lenght <= 42" do
    assert articles('big_title').invalid?
  end

  test "user: must be presence" do
    assert articles('no_user').invalid?
  end

  test 'body_as_html' do
    assert_no_match %r|```ruby|, articles('valid').body_as_html
    assert articles('valid').instance_variable_get '@html'
    assert_not_equal articles('valid').body, articles('valid').body_as_html
    assert_same articles('valid').body_as_html, articles('valid').body_as_html
  end

  test 'body_as_html: cache' do
    old_value = articles('valid').body_as_html
    articles('valid').update_attribute :title, 'Hello!' # clear cache.
    new_value = articles('valid').body_as_html
    assert_not_same old_value, new_value
  end
end
