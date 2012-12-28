require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  setup do
    @article = articles(:welcome)
  end

  test "create" do
    assert_difference( 'Article.count', 1 ) do
      post :create,
        article: { title: "Welcome!", body: "This is my blog." }
    end

    assert_response :redirect
    assert_redirected_to article_path(assigns(:article))
  end

  test "create error" do
    assert_no_difference( 'Article.count' ) do
      post :create,
        article: { title: "?" * 257, body: "This is my blog." }
    end
    
    assert_redirected_to new_article_path
  end

  test "show" do
    get :show, id: @article.to_param

    assert_response :success
    assert_template 'show'
    assert assigns(:article)
    assert assigns(:comments)
  end

  test "update" do
    put :update, id: @article.to_param,
      article: { title: "Welcome to my blog!" }

    assert_response :redirect
    assert_redirected_to assigns(:article)
  end

  test "update error" do
    put :update, id: @article.to_param,
      article: { title: "?" * 257 }

    assert_response :redirect
    assert_redirected_to edit_article_path(@article.to_param)
  end

  test "destroy" do
    assert_nothing_raised { Article.find(@article.to_param) }
    
    assert_difference( 'Article.count', -1 ) do
      delete :destroy, id: @article.to_param
    end    

    assert_response :redirect
    assert_redirected_to articles_path

    assert_raise(ActiveRecord::RecordNotFound) do
      Article.find(@article.to_param)
    end 
  end

  test "index" do
    get :index
    assert_response :success
    assert_template 'index'
    assert assigns(:articles)
  end

  test "new" do
    get :new
    assert_response :success
    assert_template 'new'
  end

  test "edit" do
    get :edit, id: @article.to_param

    assert_response :success
    assert_template 'edit'
    assert assigns(:article)
  end
end
