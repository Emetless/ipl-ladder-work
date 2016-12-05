class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, :encrypted_password, presence: true

  def delete
    Article.where(author_id: id).each(&:delete)
    Comment.where(author_id: id).each(&:delete)
    super
  end
end
