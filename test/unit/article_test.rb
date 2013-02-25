#encoding: utf-8

require 'test_helper'

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
end
