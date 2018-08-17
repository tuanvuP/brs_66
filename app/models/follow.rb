class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :follower, class_name: User.name, optional: true

  validates :user, presence: true
  validates :type_follow, presence: true
  validates :follower_id, presence: true

  enum type_follow: [:user, :book, :author]
end
