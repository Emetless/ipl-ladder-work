require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'should not save empty' do
    article = Article.new
    assert !article.save
  end

  test 'should not save with unexist user' do
    article = Article.new do |article|
      article.content = 'Test Content'
      article.author_id = 0
    end
    assert !article.save
  end

  test 'should save valid article' do
    article = Article.new do |article|
      article.content = 'Test Content'
      article.author_id = users(:user_for_tests).id
    end
    assert article.save
  end
end
