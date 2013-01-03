require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  test "create" do
    login_as @user

    assert_difference( 'Article.count', 1 ) do
      post :create,
        article: { title: "Welcome!", body: "This is my blog." }
    end

    assert_response :redirect
    assert_redirected_to assigns(:article)
  end

  test "create: save error" do
    login_as @user

    assert_no_difference( 'Article.count' ) do
      post :create,
        article: { title: "?" * 257, body: "This is my blog." }
    end

    assert_redirected_to new_article_path
  end

  test "create: user not found" do
    assert_no_difference( 'Article.count' ) do
      post :create,
        article: { title: "Welcome", body: "This is my blog." }
    end

    assert_redirected_to root_path
  end

  test "show" do
    get :show, id: @article.id

    assert assigns(:article)
    assert assigns(:comments)
    assert_response :success
    assert_template 'show'
  end

  test "show: article not found" do
    get :show, id: -1

    assert_response :missing
  end

  test "update" do
    login_as @user

    put :update, id: @article.id,
      article: { title: "Welcome to my blog!" }

    assert_response :redirect
    assert_redirected_to assigns(:article)
  end

  test "update: save error" do
    login_as @user

    put :update, id: @article.id,
      article: { title: "?" * 257 }

    assert_response :redirect
    assert_redirected_to edit_article_path(@article.id)
  end

  test "destroy" do
    login_as @user

    assert_difference( 'Article.count', -1 ) do
      delete :destroy, id: @article.id
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
    login_as @user
    get :new

    assert_response :success
    assert_template 'new'
  end

  test "edit" do
    login_as @user
    get :edit, id: @article.id

    assert assigns(:article)
    assert_response :success
    assert_template 'edit'
  end
end
