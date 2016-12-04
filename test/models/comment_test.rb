require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'should not save empty' do
    comment = Comment.new
    assert !comment.save
  end

  test 'should not save with unexist user' do
    comment = Comment.new do |comment|
      comment.content = 'Test Content'
      comment.author_id = 0
      comment.article_id = articles(:test_article).id
    end
    assert !comment.save
  end

  test 'should not save with unexist artcile' do
    comment = Comment.new do |comment|
      comment.content = 'Test Content'
      comment.author_id = users(:user_for_tests).id
      comment.article_id = 0
    end
    assert !comment.save
  end

  test 'should save valid comment' do
    comment = Comment.new do |comment|
      comment.content = 'Test Content'
      comment.author_id = users(:user_for_tests).id
      comment.article_id = articles(:test_article).id
    end
    assert comment.save
  end
end
