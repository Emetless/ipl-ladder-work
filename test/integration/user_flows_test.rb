require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  def setup
    @user_for_tests = users(:user_for_tests)
  end

  test 'sign up' do
    post user_registration_path, params:
      { 'user[email]' => 'email@example.com',
        'user[password]' => 'password',
        'user[password_confirmation]' => 'password' }

    assert_redirected_to root_path

    assert User.find_by_email('email@example.com')
  end

  test 'sign in and write an article' do
    post user_session_path, params:
      { 'user[email]' => @user_for_tests.email,
        'user[password]' => 'password' }

    assert_redirected_to root_path

    post articles_create_path, params: { 'article[content]' => 'Test Article' }
    assert_redirected_to root_path

    assert Article.where(author_id: @user_for_tests.id, content: 'Test Article')
  end

  test 'sign in and write a comment' do
    post user_session_path, params:
      { 'user[email]' => @user_for_tests.email,
        'user[password]' => 'password' }

    assert_redirected_to root_path
    follow_redirect!

    assert_select '.card>p', 'What about some tests?'

    post comments_create_path(format: :json), params:
      { 'comment[content]' => 'Test Comment',
        'comment[article_id]' => articles(:test_article).id }

    assert Comment.where(author_id: @user_for_tests.id, content: 'Test Comment', article_id: articles(:test_article).id)
  end
end
