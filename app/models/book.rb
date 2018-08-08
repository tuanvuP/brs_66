class Book < ApplicationRecord
  belongs_to :categories, optional: true
  has_many :author_books
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :mark_books
  has_many :order_detail
  has_many :favorites

  scope :list_book, ->{select :id, :name, :image, :price,
                        :category_id, :created_at}

  ratyrate_rateable "rating"
end
