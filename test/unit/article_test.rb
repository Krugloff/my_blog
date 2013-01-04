#coding: utf-8

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "create" do
    assert @article.save
  end

  test "find" do
    assert_not_nil Article.find_by_id(@article.id)
  end

  test "update" do
    assert @article.update_attribute( :title, "Welcome to my superblog!" )
  end

  test "destroy" do
    @article.destroy
    assert_nil Article.find_by_id(@article.id)
  end

  test "title must be presence" do
    @article.title = ""
    assert @article.invalid?
  end

  test "body must be presence" do
    @article.body = ""
    assert @article.invalid?
  end

  test "title less or equal 256" do
    @article.title = "?" * 257
    assert @article.invalid?
  end

  test "user must be presence" do
    @article.user = nil
    assert @article.invalid?
  end
end
