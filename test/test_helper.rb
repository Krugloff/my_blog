#encoding: utf-8

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  setup do
    @user = users(:tester)
    @user.password = "a11ri9ht"
    @user.password_confirmation = "a11ri9ht"
    @user.save

    @article = articles(:welcome)
    @article.user = @user
    @article.save

    @comment = comments(:test_comment)
    @comment.article = @article
    @comment.user = @user
    @comment.save
  end

  def login_as(a_user)
    session[:user_id] = a_user.id
  end
end
