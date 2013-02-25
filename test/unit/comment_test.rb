#encoding: utf-8

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  models :comments

  test "create" do
    ingots 'comments'
    assert Comment.create comments('valid'), without_protection: true
  end

  test "find" do
    assert Comment.find comments('valid')
  end

  test "update" do
    assert comments('valid').update_attribute( :title, "Приветствие" )
  end

  test "destroy" do
    comments('valid').destroy
    assert Comment.where( id: comments('valid').id ).empty?
  end

  test "body: must be presence" do
    assert comments('blank_body').invalid?
  end

  test "title: lenght <= 256" do
    assert comments('big_title').invalid?
  end

  test "article: must be presence" do
    assert comments('no_article').invalid?
  end

  test "user: must be presence" do
    assert comments('no_user').invalid?
  end
end
