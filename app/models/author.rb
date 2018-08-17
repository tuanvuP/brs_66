class Author < ApplicationRecord
  has_many :author_books, dependent: :destroy
  has_many :books, through: :author_books

  validates :name, presence: true
  validates :brith_year, presence: true
  validates :country, presence: true
  validates :biography, presence: true

  scope :list_author, ->{select("id, brith_year, name, country, biography").
    order created_at: :desc}

  class << self
    def search key
      where("name LIKE ?", "%#{key}%")
    end
  end
end
