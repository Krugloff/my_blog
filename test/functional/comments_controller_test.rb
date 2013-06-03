# require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  models :users, :comments, :articles

  test 'create' do
    ingots :comments
    login_as :admin

    assert_difference( 'Comment.count', 1 ) { _post comments :new }
    assert_response :redirect
    assert_redirected_to article_comments_path assigns :article
  end

  test 'ajax create' do
    ingots :comments
    login_as :admin

    assert_difference( 'Comment.count', 1 ) { _xhr_post comments :new }
    assert_response :success
    assert_template partial: '_comment'
  end

  test 'create: nested comment' do
    _setup_for_create_nested_comment

    assert_difference( 'Comment.count', 1 ) { _post @nested }
    assert_response :redirect
    assert_redirected_to article_comments_path assigns :article
  end

  test 'ajax create: nested comment' do
    _setup_for_create_nested_comment

    assert_difference( 'Comment.count', 1 ) { _xhr_post @nested }
    assert_response :success
    assert_template partial: '_comment'
  end

  test 'create: save error' do
    ingots :comments
    login_as :admin

    assert_no_difference( 'Comment.count' ) { _post Hash.new }
    assert flash.alert
    assert_response :redirect
    assert_redirected_to article_comments_path assigns :article
  end

  test 'ajax create: save error' do
    ingots :comments
    login_as :admin

    assert_no_difference( 'Comment.count' ) { _xhr_post Hash.new }
    assert !assigns(:comment).errors.empty?
    assert_response :not_acceptable
    assert_template partial: 'layouts/_alert'
  end

  test 'update' do
    login_as :admin
    _put body: 'Welcome'

    assert_response :redirect
    assert_redirected_to article_comments_path articles :valid
  end

  test 'update: save error' do
    login_as :admin
    _put body: ''

    assert flash.alert
    assert_response :redirect
    assert_redirected_to article_comments_path articles :valid
  end

  test 'destroy' do
    models :accounts
    login_as :admin

    assert_difference( 'Comment.count', -1 ) { _delete }

    assert_response :redirect
    assert_redirected_to article_comments_path articles :valid
  end

  test 'ajax destroy' do
    models :accounts
    login_as :admin

    assert_difference( 'Comment.count', -1 ) { _xhr_delete }
    assert_response :accepted
  end

  test 'index' do
    Comment.all.map &:save
    get :index, article_id: articles(:valid)
    _asserts_for_index
  end

  test 'ajax index' do
    Comment.all.map &:save
    xhr :get, :index, article_id: articles(:valid)
    _asserts_for_index
  end

  test 'index: article not found' do
    assert_raise(ActiveRecord::RecordNotFound) { get :index, article_id: 125 }
  end

  test 'ajax index: article not found' do
    assert_raise(ActiveRecord::RecordNotFound) do
      xhr :get, :index, article_id: 125
    end
  end

  test 'new nested comment' do
    login_as :admin
    get :new, article_id: articles(:valid), parent_id: comments(:valid)

    _asserts_for_new_nested_comment
  end

  test 'ajax new nested comment' do
    login_as :admin
    xhr :get, :new, article_id: articles(:valid), parent_id: comments(:valid)

    _asserts_for_new_nested_comment
  end

  test 'post preview' do
    login_as :admin
    post :preview,
      article_id: articles(:valid).id,
      comment: comments(:valid).attributes.slice('body')

    _asserts_for_preview
  end

  test 'ajax preview' do
    login_as :admin
    xhr :post, :preview,
      article_id: articles(:valid).id,
      comment: comments(:valid).attributes.slice('body')

    _asserts_for_preview
  end

  private

    def _post(params)
      post :create,
        article_id: articles(:valid).id,
        comment: params
    end

    def _put(params)
      put :update,
        id: comments(:valid).id,
        article_id: articles(:valid).id,
        comment: params
    end

    def _delete
      delete :destroy,
        id: comments(:valid).id,
        article_id: articles(:valid).id
    end

    def _xhr_post(params)
      xhr :post, :create,
        article_id: articles(:valid).id,
        comment: params
    end

    def _xhr_delete
      xhr :delete, :destroy,
        id: comments(:valid).id,
        article_id: articles(:valid).id
    end

    def _asserts_for_index
      assert assigns  :article
      assert assigns  :comments
      assert assigns  :title
      assert_response :success
      assert_template :index
    end

    def _asserts_for_new_nested_comment
      assert assigns(:comment).new_record?
      assert assigns  :title
      assert assigns  :parent_id
      assert_response :success
      assert_template :new
    end

    def _setup_for_create_nested_comment
      ingots :comments
      login_as :admin
      @nested = comments(:child).slice :body, :parent_id
    end

    def _asserts_for_preview
      assert assigns(:comment).new_record?
      assert_response :success
      assert_template :preview
    end
end
