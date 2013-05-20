class ArticlesControllerTest < ActionController::TestCase
  test 'create: user not found' do
    ingots :articles

    assert_no_difference( 'Article.count' ) { _post articles :new }
    assert_redirected_to new_session_path
  end

  test 'create: user not admin' do
    ingots :articles
    login_as :client

    assert_no_difference( 'Article.count' ) { _post articles :new }
    assert flash.alert
    assert_redirected_to new_session_path
  end

  test 'update: user not author' do
    login_as :client
    _put title: 'I hate you!'

    _asserts_for_update_not_author
  end

  test 'ajax update: user not author' do
    login_as :client
    _xhr_put title: 'I hate you!'

    _asserts_for_update_not_author
  end

  private

    def _asserts_for_update_not_author
      assert flash.alert
      assert_response :redirect
      assert_redirected_to assigns :article
    end
end

class UsersControllerTest < ActionController::TestCase
  test 'show: user not found' do
    get :show

    assert flash.alert
    assert_response :redirect
    assert_redirected_to new_session_path
  end
end

class CommentsControllerTest < ActionController::TestCase
  test 'update: user not author' do
    login_as :client
    _put body: 'I hate you!'

    assert flash.alert
    assert_response :redirect
    assert_redirected_to article_comments_path articles :valid
  end

  test 'destroy: user not found' do
    assert_no_difference('Comment.count') { _delete }
    _asserts_for_destroy_not_found_user
  end

  test 'ajax destroy: user not found' do
    assert_no_difference('Comment.count') { _xhr_delete }
    _asserts_for_destroy_not_found_user
  end

  private

    def _asserts_for_destroy_not_found_user
      assert flash.alert
      assert_response :redirect
      assert_redirected_to new_session_path
    end
end