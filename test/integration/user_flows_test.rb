require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  def setup
    @user_for_tests = users(:user_for_tests)
  end

  test 'sign in and write an article' do
    get root_path
    assert_redirected_to new_user_session_path

    post user_session_path, params: { 'user[email]' => @user_for_tests.email, 'user[password]' => 'password' }
    assert_redirected_to root_path

    get articles_new_path
    assert_response :success

    post articles_create_path, params: { content: 'Test Article' }
    assert_redirected_to articles_index_path
  end

  test 'sign up and watch existing article' do
    get root_path
    assert_redirected_to new_user_session_path

    post user_session_path, params: { 'user[email]' => 'another.email@email.com', 'user[password]' => 'password' }
    assert_response :success

    post user_registration_path, params: { 'user[email]' => 'another.email@email.com', 'user[password]' => 'password' }
    assert_redirected_to root_path

    # p articles(:test_article)
    # p @user_for_tests.id

    get users_index_path, params: { id: @user_for_tests.id }
    # assert_response :success
    p 

    assert_select 'card>p'
  end
end
