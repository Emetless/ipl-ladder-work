class Article < ApplicationRecord
  validates :content, :author_id, :author_exists, presence: true

  def delete
    Comment.where(article_id: id).each(&:delete)
    super
  end

  private def author_exists
    User.exists? author_id
  end
end
