class Book < ApplicationRecord
  include Filterable

  belongs_to :categories, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :mark_books
  has_many :order_detail
  has_many :favorites
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books

  accepts_nested_attributes_for :author_books

  scope :list_book, ->{select :id, :name, :image, :price,
                        :category_id, :created_at}
  scope :by_book_ids, -> book_ids{where id: book_ids}
  scope :by_id, -> book_id{where id: book_id}
  scope :search_name, -> search_name {where "name LIKE ?", "%#{search_name}%"}
  scope :category_id, -> category_id {where category_id: category_id}
  scope :order_by, ->{order created_at: :desc}
  scope :read_by, ->user{joins(:mark_books).where("mark_books.user_id = ? AND
    mark_books.status = ?", user.id,
    MarkBook.statuses[:reading]).order created_at: :desc}
  scope :favored_by, ->user{joins(:favorites).where("favorites.user_id = ?",
    user.id).order created_at: :desc}

  validates :name, presence: true
  validates :description, presence: true
  validates :image, presence: true
  validates :publish_date, presence: true
  validates :price, presence: true
  validates :category_id, presence: true

  scope :like_max, (lambda do
    joins(:likes).select(:id, :image, :name, :price, "count(books.id) as like_num")
      .group(:id).order("count(books.id) desc").limit(4)
  end)
  scope :reading_max, (lambda do |status|
    joins(:mark_books).select(:id, :image, :name, :price, "count(books.id) as reading")
      .where("mark_books.status": status).group(:book_id).order("count(books.id) desc").limit(4)
  end)

  ratyrate_rateable "rating"
  mount_uploader :image, ImageUploader

  class << self
    def search key
      where("name LIKE ? OR description LIKE ?", "%#{key}%", "%#{key}%")
    end
  end
end

