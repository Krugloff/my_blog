#coding: utf-8

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = comments(:test_comment)
  end

  test "create" do
    comment = Comment.new
    comment.title = ""
    comment.body = "Ура! Еще один зомби!"
    comment.article = articles(:welcome)

    assert comment.save
  end

  test "find" do
    assert_nothing_raised { Comment.find @comment.id }
  end

  test "update" do
    assert @comment.update_attribute( :title, "Приветствие" )
  end

  test "destroy" do
    @comment.destroy

    assert_raise(ActiveRecord::RecordNotFound) { Comment.find @comment.id }
  end

  test "body must be presence" do
    @comment.body = ""
    assert !@comment.save
  end

  test "title less or equal 256" do
    @comment.title = "?" * 257
    assert !@comment.save
  end

  test "article must be presence" do
    assert !@comment.save
  end
end
