class Author < ApplicationRecord
  has_many :author_books, dependent: :destroy
  has_many :books, through: :author_books

  validates :name, presence: true
  validates :brith_year, presence: true
  validates :phone, presence: true
  validates :address, presence: true

  scope :list_author, ->{select("id, name, phone, address, brith_year").
    order name: :asc}

  class << self
    def search key
      where("name LIKE ? OR address LIKE ? OR phone LIKE ?", "%#{key}%", "%#{key}%", "#{key}")
    end
  end
end
