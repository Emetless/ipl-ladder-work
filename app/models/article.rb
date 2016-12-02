class Article < ApplicationRecord
  validates :content, :author_id, presence: true
end
