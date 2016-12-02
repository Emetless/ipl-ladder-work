class Comment < ApplicationRecord
  validates :content, :article_id, :author_id, presence: true
end
