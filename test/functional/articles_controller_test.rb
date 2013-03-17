require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  models 'users', 'accounts', 'articles'

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
    assert_redirected_to new_session_path
  end

  test "show" do
    get :show, id: articles('valid').id

    assert assigns(:article)
    assert assigns(:title)
    assert  cookies[:article_id],
            cookies.instance_variable_get(:@cookies).inspect
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
    assert assigns(:title)
    assert_response :success
    assert_template 'index'
  end

  test "ajax index" do
    xhr :get, :index

    assert assigns(:articles)
    assert assigns(:title)
    assert_response :success
    assert_template 'index'
  end

  test "new" do
    login_as users('valid')
    get :new

    assert assigns(:article)
    assert assigns(:title)
    assert_response :success
    assert_template 'new'
  end

  test "edit" do
    login_as users('valid')
    get :edit, id: articles('valid').id

    assert assigns(:article)
    assert assigns(:title)
    assert_response :success
    assert_template 'edit'
  end

  test 'last' do
    get :last

    assert assigns(:article), assigns.inspect
    assert_response :redirect
    assert_redirected_to articles('valid')
  end

  test 'last: no article' do
    ingots('articles')
    get :last

    assert_nil assigns(:article), assigns.inspect
    assert_response :redirect
    assert_redirected_to articles_path
  end

  test "ajax show" do
    xhr :get, :show, id: articles('valid').id

    assert assigns(:article)
    assert assigns(:title)
    assert_response :success
    assert_template 'show'
  end

  test "ajax show: article not found" do
    assert_raise(::ActiveRecord::RecordNotFound) { xhr :get, :show, id: -1 }
  end

  test "ajax update" do
    login_as users('valid')
    _xhr_put title: "Welcome to my blog!"

    assert_response :redirect
    assert_redirected_to assigns(:article)
  end

  test "ajax update: save error" do
    login_as users('valid')
    _xhr_put title: '?' * 257

    assert flash.alert
    assert_response :redirect
    assert_redirected_to edit_article_path( assigns(:article).id )
  end

  test "ajax update: user not author" do
    login_as users('not_admin')
    _xhr_put title: "I hate you!"

    assert flash.alert
    assert_response :redirect
    assert_redirected_to @article
  end

  test "ajax new" do
    login_as users('valid')
    xhr :get, :new

    assert assigns(:article)
    assert assigns(:title)
    assert_response :success
    assert_template 'new'
  end

  test "ajax edit" do
    login_as users('valid')
    xhr :get, :edit, id: articles('valid').id

    assert assigns(:article)
    assert assigns(:title)
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

    def _xhr_put(params)
      xhr :put, :update,
        id: articles('valid').id,
        article: params
    end
end
