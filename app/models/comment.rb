class Comment < ApplicationRecord
  validates :content, :article_id, :author_id, :author_exists, :article_exists, presence: true

  private

  def author_exists
    User.exists? author_id
  end

  def article_exists
    Article.exists? article_id
  end
end
