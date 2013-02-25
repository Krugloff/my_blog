require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  models 'users', 'articles'

  test "create" do
    ingots 'articles'
    login_as users('valid')

    assert_difference( 'Article.count', 1 ) { _post articles('new') }
    assert_response :redirect
    assert_redirected_to assigns(:article)
  end

  test "create: save error" do
    ingots 'articles'
    login_as users('valid')

    assert_no_difference( 'Article.count' ) do
      _post articles('invalid_new')
    end

    assert flash.alert
    assert_redirected_to new_article_path
  end

  test "create: user not found" do
    ingots 'articles'

    assert_no_difference( 'Article.count' ) { _post articles('new') }
    assert_redirected_to new_session_path
  end

  test "create: user not admin" do
    ingots 'articles'
    login_as users('not_admin')

    assert_no_difference( 'Article.count' ) { _post articles('new') }
    assert flash.alert
    assert_redirected_to root_path
  end

  test "show" do
    get :show, id: articles('valid').id

    assert assigns(:article)
    assert_response :success
    assert_template 'show'
  end

  test "show: article not found" do
    assert_raise(::ActiveRecord::RecordNotFound) { get :show, id: -1 }
  end

  test "update" do
    login_as users('valid')
    _put title: "Welcome to my blog!"

    assert_response :redirect
    assert_redirected_to assigns(:article)
  end

  test "update: save error" do
    login_as users('valid')
    _put title: '?' * 257

    assert flash.alert
    assert_response :redirect
    assert_redirected_to edit_article_path( assigns(:article).id )
  end

  test "update: user not author" do
    login_as users('not_admin')
    _put title: "I hate you!"

    assert flash.alert
    assert_response :redirect
    assert_redirected_to @article
  end

  test "destroy" do
    login_as users('valid')

    assert_difference( 'Article.count', -1 ) do
      delete :destroy, id: articles('valid').id
    end

    assert_response :redirect
    assert_redirected_to articles_path
  end

  test "index" do
    get :index

    assert assigns(:articles)
    assert_response :success
    assert_template 'index'
  end

  test "new" do
    login_as users('valid')
    get :new

    assert_response :success
    assert_template 'new'
  end

  test "edit" do
    login_as users('valid')
    get :edit, id: articles('valid').id

    assert assigns(:article)
    assert_response :success
    assert_template 'edit'
  end

  private

    def _post(params)
      post :create,
        article: params
    end

    def _put(params)
      put :update,
        id: articles('valid').id,
        article: params
    end
end
