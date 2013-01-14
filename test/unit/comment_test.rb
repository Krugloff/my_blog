#encoding: utf-8

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "create" do
    assert @comment.save
  end

  test "find" do
    assert Comment.find(@comment.id)
  end

  test "update" do
    assert @comment.update_attribute( :title, "Приветствие" )
  end

  test "destroy" do
    @comment.destroy
    assert Comment.where(id: @comment.id).empty?
  end

  test "body: must be presence" do
    @comment.body = ""
    assert @comment.invalid?
  end

  test "title: lenght <= 256" do
    @comment.title = "?" * 257
    assert @comment.invalid?
  end

  test "article: must be presence" do
    @comment.article = nil
    assert @comment.invalid?
  end

  test "user: must be presence" do
    @comment.user = nil
    assert @comment.invalid?
  end
end
