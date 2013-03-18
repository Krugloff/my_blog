require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  models 'users', 'comments', 'articles', 'accounts'

  test "create" do
    ingots 'comments'
    login_as users('admin')

    assert_difference( 'Comment.count', 1 ) { _post comments 'new' }
    assert_response :redirect
    assert_redirected_to article_comments_path( articles 'valid' )
  end

  test "ajax create" do
    ingots 'comments'
    login_as users('admin')

    assert_difference( 'Comment.count', 1 ) { _xhr_post comments 'new' }
    assert_response :success
    assert_template partial: '_comment'
  end

  test "create: save error" do
    ingots 'comments'
    login_as users('admin')

    assert_no_difference( 'Comment.count' ) { _post comments 'invalid_new' }
    assert flash.alert
    assert_response :redirect
    assert_redirected_to article_comments_path( articles 'valid' )
  end

  test "ajax create: save error" do
    ingots 'comments'
    login_as users('admin')

    assert_no_difference( 'Comment.count' ) do
      _xhr_post comments 'invalid_new'
    end
    assert !assigns('comment').errors.empty?
    assert_response :success
    assert_template partial: 'layouts/_alert'
  end

  test "update" do
    login_as users('admin')
    _put title: "Welcome"

    assert_response :redirect
    assert_redirected_to article_comments_path( articles 'valid' )
  end

  test "update: save error" do
    login_as users('admin')
    _put body: ""

    assert flash.alert
    assert_response :redirect
    assert_redirected_to article_comments_path( articles 'valid' )
  end

  test "update: user not author" do
    login_as users('client')
    _put body: "I hate you!"

    assert flash.alert
    assert_response :redirect
    assert_redirected_to article_comments_path( articles 'valid' )
  end

  test "destroy" do
    login_as users('admin')

    assert_difference( "Comment.count", -1 ) { _delete }

    assert_response :redirect
    assert_redirected_to article_comments_path( articles 'valid' )
  end

  test "ajax destroy" do
    login_as users('admin')

    assert_difference( "Comment.count", -1 ) { _xhr_delete }
    assert_response :success
  end

  test "destroy: user not found" do
    assert_no_difference("Comment.count") { _delete }
    _asserts_for_destroy_not_found_user
  end

  test "ajax destroy: user not found" do
    assert_no_difference("Comment.count") { _xhr_delete }
    _asserts_for_destroy_not_found_user
  end

  test "index" do
    get :index, article_id: articles('valid')
    _asserts_for_index
  end

  test "ajax index" do
    xhr :get, :index, article_id: articles('valid')
    _asserts_for_index
  end

  test "index: article not found" do
    assert_raise(::ActiveRecord::RecordNotFound) do
      get :index, article_id: 125
    end
  end

  test "ajax index: article not found" do
    assert_raise(::ActiveRecord::RecordNotFound) do
      xhr :get, :index, article_id: 125
    end
  end

  private

    def _post(params)
      post :create,
        article_id: articles('valid').id,
        comment: params
    end

    def _put(params)
      put :update,
        id: comments('valid').id,
        article_id: articles('valid').id,
        comment: params
    end

    def _delete
      delete :destroy,
        id: comments('valid').id,
        article_id: articles('valid').id
    end

    def _xhr_post(params)
      xhr :post, :create,
        article_id: articles('valid').id,
        comment: params
    end

    def _xhr_delete
      xhr :delete, :destroy,
        id: comments('valid').id,
        article_id: articles('valid').id
    end

    def _asserts_for_destroy_not_found_user
      assert flash.alert
      assert_response :redirect
      assert_redirected_to new_session_path
    end

    def _asserts_for_index
      assert assigns(:article)
      assert assigns(:comments)
      assert assigns(:title)
      assert_response :success
      assert_template 'index'
    end
end
