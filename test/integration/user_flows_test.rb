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

  test 'fail sign up' do
    post user_registration_path, params:
      { 'user[email]' => 'email@example.com',
        'user[password]' => 'password',
        'user[password_confirmation]' => 'password1' }

    assert_response :success # Controller didn't redirect to root_path
  end

  test 'sign in and fail to write an article' do
    post user_session_path, params:
      { 'user[email]' => @user_for_tests.email,
        'user[password]' => 'password' }

    assert_redirected_to root_path

    post articles_create_path, params: { 'article[content]' => '' }
    assert_redirected_to root_path

    assert !Article.exists?(content: '')
  end

  test 'sign in and fail to write a comment' do
    post user_session_path, params:
      { 'user[email]' => @user_for_tests.email,
        'user[password]' => 'password' }

    assert_redirected_to root_path
    follow_redirect!

    assert_select '.card>p', 'What about some tests?'

    post comments_create_path(format: :json), params:
      { 'comment[content]' => '',
        'comment[article_id]' => articles(:test_article).id }

    assert !Comment.exists?(author_id: @user_for_tests.id, content: '', article_id: articles(:test_article).id)

    post comments_create_path(format: :json), params:
      { 'comment[content]' => 'Test Comment',
        'comment[article_id]' => 0 }

    assert !Comment.exists?(author_id: @user_for_tests.id, content: 'Test Comment', article_id: 0)
  end

  test 'should delete all comments and articles of destroing user' do
    user = User.new email: 'email@test.com', password: 'password', password_confirmation: 'password'
    assert user.save

    article = Article.new content: 'Testing!', author_id: user.id
    assert article.save

    comment = Comment.new content: 'Testing!', author_id: user.id, article_id: article.id
    assert comment.save

    user.delete

    assert !Article.exists?(author_id: user.id)
    assert !Comment.exists?(author_id: user.id)
    assert !Comment.exists?(article_id: article.id)
  end
end
