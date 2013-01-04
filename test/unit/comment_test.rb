#coding: utf-8

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "create" do
    assert @comment.save
  end

  test "find" do
    assert_not_nil Comment.find_by_id(@comment.id)
  end

  test "update" do
    assert @comment.update_attribute( :title, "Приветствие" )
  end

  test "destroy" do
    @comment.destroy
    assert_nil Comment.find_by_id(@comment.id)
  end

  test "body must be presence" do
    @comment.body = ""
    assert @comment.invalid?
  end

  test "title less or equal 256" do
    @comment.title = "?" * 257
    assert @comment.invalid?
  end

  test "article must be presence" do
    @comment.article = nil
    assert @comment.invalid?
  end

  test "user must be presence" do
    @comment.user = nil
    assert @comment.invalid?
  end
end
