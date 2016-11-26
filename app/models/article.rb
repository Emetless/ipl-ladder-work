class Article < ApplicationRecord
  def save
    super if content && author_id
  end
end
