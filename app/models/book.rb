class Book < ApplicationRecord
  include Filterable

  belongs_to :categories, optional: true
  has_many :author_books
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :mark_books
  has_many :order_detail
  has_many :favorites

  ratyrate_rateable "rating"

  scope :list_book, ->{select :id, :name, :image, :price,
                        :category_id, :created_at}

  scope :search_name, -> search_name {where "name LIKE ?", "%#{search_name}%"}
  scope :category_id, -> category_id {where category_id: category_id}
end
