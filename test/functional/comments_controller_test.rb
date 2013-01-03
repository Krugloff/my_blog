require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "create" do
    login_as @user

    assert_difference( 'Comment.count', 1 ) do
      post :create,
        article_id: @article,
        comment: { body: "This is comment." }
    end

    assert_response :redirect
    assert_redirected_to @article
  end

  test "create: save error" do
    login_as @user

    assert_no_difference( 'Comment.count' ) do
      post :create,
        article_id: @article.id,
        comment: { title: "?" * 257 }
    end

    assert_response :redirect
    assert_redirected_to @article
  end

  test "update" do
    login_as @user

    put :update,
      id: @comment.id,
      article_id: @article.id,
      comment: { title: "Welcome" }

    assert_response :redirect
    assert_redirected_to @article
  end

  test "update: save error" do
    login_as @user

    put :update,
      id: @comment.id,
      article_id: @article.id,
      comment: { body: "" }

    assert_response :redirect
    assert_redirected_to @article
  end

  test "destroy" do
    login_as @user

    assert_difference( "Comment.count", -1 ) do
      delete :destroy,
        id: @comment.id,
        article_id: @article.id
      end

    assert_response :redirect
    assert_redirected_to @article
  end

  test "destroy: user not found" do
    assert_no_difference "Comment.count" do
      delete :destroy,
        id: @comment.id,
        article_id: @article.id
    end

    assert_response :redirect
    assert_redirected_to root_path
  end
end
