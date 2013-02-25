require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  models 'users', 'comments', 'articles'

  test "create" do
    ingots 'comments'
    login_as users('valid')

    assert_difference( 'Comment.count', 1 ) { _post comments 'new' }
    assert_response :redirect
    assert_redirected_to article_comments_path( articles 'valid' )
  end

  test "create: save error" do
    ingots 'comments'
    login_as users('valid')

    assert_no_difference( 'Comment.count' ) { _post comments 'invalid_new' }
    assert flash.alert
    assert_response :redirect
    assert_redirected_to article_comments_path( articles 'valid' )
  end

  test "update" do
    login_as users('valid')
    _put title: "Welcome"

    assert_response :redirect
    assert_redirected_to article_comments_path( articles 'valid' )
  end

  test "update: save error" do
    login_as users('valid')
    _put body: ""

    assert flash.alert
    assert_response :redirect
    assert_redirected_to article_comments_path( articles 'valid' )
  end

  test "update: user not author" do
    login_as users('not_admin')
    _put body: "I hate you!"

    assert flash.alert
    assert_response :redirect
    assert_redirected_to article_comments_path( articles 'valid' )
  end

  test "destroy" do
    login_as users('valid')

    assert_difference( "Comment.count", -1 ) { _delete }

    assert_response :redirect
    assert_redirected_to article_comments_path( articles 'valid' )
  end

  test "destroy: user not found" do
    assert_no_difference("Comment.count") { _delete }

    assert flash.alert
    assert_response :redirect
    assert_redirected_to new_session_path
  end

  test "index" do
    get :index, article_id: articles('valid')

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
end
