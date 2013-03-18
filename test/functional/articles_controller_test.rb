require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  models 'users', 'accounts', 'articles'

  test "create" do
    ingots 'articles'
    login_as users('admin')

    assert_difference( 'Article.count', 1 ) { _post articles('new') }
    assert_response :redirect
    assert_redirected_to assigns(:article)
  end

  test "create: save error" do
    ingots 'articles'
    login_as users('admin')

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
    login_as users('client')

    assert_no_difference( 'Article.count' ) { _post articles('new') }
    assert flash.alert
    assert_redirected_to new_session_path
  end

  test "show" do
    get :show, id: articles('valid').id

    assert  cookies[:article_id],
            cookies.instance_variable_get(:@cookies).inspect
    _asserts_for_show
  end

  test "ajax show" do
    xhr :get, :show, id: articles('valid').id
    _asserts_for_show
  end

  test "show: article not found" do
    assert_raise(::ActiveRecord::RecordNotFound) { get :show, id: -1 }
  end

  test "ajax show: article not found" do
    assert_raise(::ActiveRecord::RecordNotFound) { xhr :get, :show, id: -1 }
  end

  test "update" do
    login_as users('admin')
    _put title: "Welcome to my blog!"

    _asserts_for_update
  end

  test "ajax update" do
    login_as users('admin')
    _xhr_put title: "Welcome to my blog!"

    _asserts_for_update
  end

  test "update: save error" do
    login_as users('admin')
    _put title: '?' * 257

    _asserts_for_update_save_error
  end

  test "ajax update: save error" do
    login_as users('admin')
    _xhr_put title: '?' * 257

    _asserts_for_update_save_error
  end

  test "update: user not author" do
    login_as users('client')
    _put title: "I hate you!"

    _asserts_for_update_not_author
  end

  test "ajax update: user not author" do
    login_as users('client')
    _xhr_put title: "I hate you!"

    _asserts_for_update_not_author
  end

  test "destroy" do
    login_as users('admin')

    assert_difference( 'Article.count', -1 ) do
      delete :destroy, id: articles('valid').id
    end

    assert_response :redirect
    assert_redirected_to articles_path
  end

  test "index" do
    get :index
    _asserts_for_index
  end

  test "ajax index" do
    xhr :get, :index
    _asserts_for_index
  end

  test "new" do
    login_as users('admin')
    get :new

    _asserts_for_new
  end

  test "ajax new" do
    login_as users('admin')
    xhr :get, :new

    _asserts_for_new
  end

  test "edit" do
    login_as users('admin')
    get :edit, id: articles('valid').id

    _asserts_for_edit
  end

  test "ajax edit" do
    login_as users('admin')
    xhr :get, :edit, id: articles('valid').id

    _asserts_for_edit
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

    def _asserts_for_show
      assert assigns(:article)
      assert assigns(:title)
      assert_response :success
      assert_template 'show'
    end

    def _asserts_for_update
      assert_response :redirect
      assert_redirected_to assigns(:article)
    end

    def _asserts_for_update_save_error
      assert flash.alert
      assert_response :redirect
      assert_redirected_to edit_article_path( assigns(:article).id )
    end

    def _asserts_for_update_not_author
      assert flash.alert
      assert_response :redirect
      assert_redirected_to @article
    end

    def _asserts_for_index
      assert assigns(:articles)
      assert assigns(:title)
      assert_response :success
      assert_template 'index'
    end

    def _asserts_for_new
      assert assigns(:article)
      assert assigns(:title)
      assert_response :success
      assert_template 'new'
    end

    def _asserts_for_edit
      assert assigns(:article)
      assert assigns(:title)
      assert_response :success
      assert_template 'edit'
    end
end