class Order < ApplicationRecord
  enum status: {unchecked: 0, checked: 1, canceled: 2}

  belongs_to :user
  has_many :order_details
  has_many :products, through: :order_details

  validates :full_name, presence: true
  validates :phone, presence: true
  validates :address, presence: true

  scope :by_id, ->user{where user_id: user}
  scope :by_status, ->value{where status: value}
end
