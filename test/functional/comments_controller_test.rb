require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "create" do
    login_as @user
    @comment_attr = { body: "This is comment." }

    assert_difference( 'Comment.count', 1 ) {_post}
    assert_response :redirect
    assert_redirected_to article_comments_path(@article)
  end

  test "create: save error" do
    login_as @user
    @comment_attr = { title: "?" * 257 }

    assert_no_difference( 'Comment.count' ) {_post}
    assert flash.alert
    assert_response :redirect
    assert_redirected_to article_comments_path(@article)
  end

  test "update" do
    login_as @user
    @comment_attr = { title: "Welcome" }
    _put

    assert_response :redirect
    assert_redirected_to article_comments_path(@article)
  end

  test "update: save error" do
    login_as @user
    @comment_attr = { body: "" }
    _put

    assert flash.alert
    assert_response :redirect
    assert_redirected_to article_comments_path(@article)
  end

  test "update: user not author" do
    login_as users(:hacker)
    @comment_attr = { body: "I hate you!" }
    _put

    assert flash.alert
    assert_response :redirect
    assert_redirected_to article_comments_path(@article)
  end

  test "destroy" do
    login_as @user

    assert_difference( "Comment.count", -1 ) {_delete}

    assert_response :redirect
    assert_redirected_to article_comments_path(@article)
  end

  test "destroy: user not found" do
    assert_no_difference("Comment.count") {_delete}

    assert flash.alert
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "index" do
    get :index, article_id: @article.id

    assert assigns(:article)
    assert assigns(:comments)
    assert_response :success
    assert_template "index"
  end

  test "index: article not found" do
    assert_raise(::ActionController::RoutingError) do
      get :show, article_id: 125
    end
  end

  private

    def _post
      post :create,
        article_id: @article.id,
        comment: @comment_attr
    end

    def _put
      put :update,
        id: @comment.id,
        article_id: @article.id,
        comment: @comment_attr
    end

    def _delete
      delete :destroy,
        id: @comment.id,
        article_id: @article.id
    end
end
