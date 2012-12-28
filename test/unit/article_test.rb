#coding: utf-8

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  setup do
    @article = articles(:welcome)
  end

  test "create" do
    article = Article.new
    article.title = "Welcome to my blog!"
    article.body = File.read "test/fixtures/article.md"

    assert article.save
  end

  test "find" do
    assert_nothing_raised { Article.find @article.id }
  end

  test "update" do
    assert @article.update_attribute( :title, "Welcome to my superblog!" )
  end

  test "destroy" do
    @article.destroy

    assert_raise(ActiveRecord::RecordNotFound) { Article.find @article.id }
  end

  test "comments" do 
    @article.comments = [comments(:test_comment)]
    @article.save
    assert_nothing_raised { Comment.find @article.comment_ids }
  end

  test "title must be presence" do
    article = Article.new
    article.body = "This is my blog"
    assert !article.save
  end

  test "body must be presence" do
    article = Article.new
    article.title = "Welcome"
    assert !article.save
  end

  test "title less or equal 256" do
    @article.title = "?" * 257
    assert !@article.save
  end
end
