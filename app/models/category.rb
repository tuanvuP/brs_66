class Category < ApplicationRecord
  has_many :books

  scope :list_category, ->{select("id, title, description").
    order created_at: :desc}
end
