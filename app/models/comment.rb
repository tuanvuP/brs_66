class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :content, length: {minimum: Settings.comment.minimum,
    maximum: Settings.comment.maximum}
end
