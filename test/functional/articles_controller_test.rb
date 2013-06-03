# require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  models :users, :accounts, :articles

  test 'create' do
    ingots :articles
    login_as :admin

    assert_difference( 'Article.count', 1 ) { _post articles :new }
    assert_response :redirect
    assert_redirected_to assigns :article
  end

  test 'create: save error' do
    ingots :articles
    login_as :admin

    assert_no_difference( 'Article.count' ) do
      _post articles(:new).slice :body
    end

    assert flash.alert
    assert_redirected_to new_article_path
  end

  test 'show' do
    articles(:valid).save
    get :show, id: articles(:valid).id

    assert  cookies[:article_id],
            cookies.instance_variable_get(:@cookies).inspect
    _asserts_for_show
  end

  test 'ajax show' do
    articles(:valid).save
    xhr :get, :show, id: articles(:valid).id
    _asserts_for_show
  end

  test 'update' do
    login_as :admin
    _put title: 'Welcome to my blog!'

    _asserts_for_update
  end

  test 'ajax update' do
    login_as :admin
    _xhr_put title: 'Welcome to my blog!'

    _asserts_for_update
  end

  test 'update: save error' do
    login_as :admin
    _put title: '?' * 257

    _asserts_for_update_save_error
  end

  test 'ajax update: save error' do
    login_as :admin
    _xhr_put title: '?' * 257

    _asserts_for_update_save_error
  end

  test 'destroy' do
    login_as :admin

    assert_difference( 'Article.count', -1 ) do
      delete :destroy, id: articles(:valid).id
    end

    assert_nil cookies[:article_id]
    assert_response :redirect
    assert_redirected_to articles_path
  end

  test 'index' do
    articles(:valid).save
    get :index
    _asserts_for_index
  end

  test 'ajax index' do
    articles(:valid).save
    xhr :get, :index
    _asserts_for_index
  end

  test 'new' do
    login_as :admin
    get :new

    _asserts_for_new
  end

  test 'ajax new' do
    login_as :admin
    xhr :get, :new

    _asserts_for_new
  end

  test 'edit' do
    login_as :admin
    get :edit, id: articles(:valid).id

    _asserts_for_edit
  end

  test 'ajax edit' do
    login_as :admin
    xhr :get, :edit, id: articles(:valid).id

    _asserts_for_edit
  end

  test 'last' do
    get :last

    assert assigns(:article), assigns.inspect
    assert_response :redirect
    assert_redirected_to articles(:valid)
  end

  test 'last: no article' do
    ingots :articles
    get :last

    assert_nil assigns(:article), assigns.inspect
    assert_response :redirect
    assert_redirected_to articles_path
  end

  test 'post preview' do
    login_as :admin
    post :preview,
      article: articles(:valid).attributes.slice('title', 'body')

    assert assigns(:article).new_record?
    _asserts_for_preview
  end

  test 'put preview' do
    login_as :admin
    put :preview,
      id: articles(:valid).id,
      article: articles(:valid).attributes.slice('title', 'body')

    assert assigns(:article).persisted?
    _asserts_for_preview
  end

  test 'ajax preview' do
    login_as :admin
    xhr :put, :preview,
      id: articles(:valid).id,
      article: articles(:valid).attributes.slice('title', 'body')

    _asserts_for_preview
  end

  private

    def _post(params)
      post :create,
        article: params
    end

    def _put(params)
      put :update,
        id: articles(:valid).id,
        article: params
    end

    def _xhr_put(params)
      xhr :put, :update,
        id: articles(:valid).id,
        article: params
    end

    def _asserts_for_show
      _assert_assigns
      assert_response :success
      assert_template :show
    end

    def _asserts_for_update
      assert_response :redirect
      assert_redirected_to assigns :article
    end

    def _asserts_for_update_save_error
      assert flash.alert
      assert_response :redirect
      assert_redirected_to edit_article_path assigns :article
    end

    def _asserts_for_index
      assert assigns  :articles
      assert assigns  :title
      assert_response :success
      assert_template :index
    end

    def _asserts_for_new
      _assert_assigns
      assert_response :success
      assert_template :new
    end

    def _asserts_for_edit
      _assert_assigns
      assert_response :success
      assert_template :edit
    end

    def _assert_assigns
      assert assigns :article
      assert assigns :title
    end

    def _asserts_for_preview
      assert_response :success
      assert_template :preview
    end
end