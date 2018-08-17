class Author < ApplicationRecord
  has_many :author_books, dependent: :destroy
  has_many :books, through: :author_books
  has_many :follows

  validates :name, presence: true
  validates :brith_year, presence: true
  validates :country, presence: true
  validates :biography, presence: true

  scope :list_author, ->{select("id, brith_year, name, country, biography").
    order created_at: :desc}
  scope :following_author, (lambda do|user|
    joins("LEFT JOIN follows ON follows.follower_id = authors.id")
    .where("follows.type_follow = ? AND follows.user_id = ?",
    Follow.type_follows[:author], user.id).order(created_at: :desc)
  end)

  class << self
    def search key
      where("name LIKE ?", "%#{key}%")
    end
  end
end
