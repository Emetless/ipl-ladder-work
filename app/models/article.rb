class Article < ApplicationRecord
  validates :content, :author_id, :author_exists, presence: true

  private def author_exists
    User.exists? author_id
  end
end
