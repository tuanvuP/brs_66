class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :follower, class_name: User.name

  validates :user, presence: true
  validates :type, presence: true
  validates :follower_id, presence: true

  enum type: [:user, :book, :author]
end
