require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:test_comment)
    @article = articles(:welcome)
    @article.comments << @comment
  end

  test "create" do
    assert_difference( 'Comment.count', 1 ) do
      post :create,
        article_id: @article.to_param,
        comment: { body: "This is comment." }
    end

    assert_response :redirect
    assert_redirected_to article_path(@article)
  end

  test "create error" do
    assert_no_difference( 'Comment.count' ) do
      post :create,
        article_id: @article.to_param,
        comment: { title: "?" * 257 }
    end
    
    assert_response :redirect
    assert_redirected_to article_path(@article)
  end

  test "update" do
    put :update,
      id: @comment.to_param,
      article_id: @article.to_param,
      comment: { title: "Welcome" }

    assert_response :redirect
    assert_redirected_to article_path(@article)
  end

  test "update error" do
    put :update,
      id: @comment.to_param,
      article_id: @article.to_param,
      comment: { body: "" }

    assert_response :redirect
    assert_redirected_to article_path(@article)
  end

  test "destroy" do
    assert_nothing_raised { Comment.find(@comment.to_param) }

    assert_difference( "Comment.count", -1 ) do
      delete :destroy,
        id: @comment.to_param,
        article_id: @article.to_param
      end
    
    assert_response :redirect
    assert_redirected_to article_path(@article)

    assert_raise(ActiveRecord::RecordNotFound) do
      Comment.find(@comment.to_param)
    end
  end
end
