class Author < ApplicationRecord
  has_many :author_books

  validates :name, presence: true
  validates :brith_year, presence: true
  validates :phone, presence: true
  validates :address, presence: true

  scope :list_author, ->{select("name, phone, address, brith_year").
    order name: :asc}
end
