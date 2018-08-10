class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :comments
  has_many :likes
  has_many :mark_books
  has_many :favorites
  has_many :orders
  has_many :liked, through: :likes, source: :book
  has_many :favorited, through: :favorites, source: :book

  has_many :active_follows, class_name: Follow.name, foreign_key: :user_id,
    dependent: :destroy
  has_many :passive_follows, class_name: Follow.name, foreign_key: :follower_id,
    dependent: :destroy
  has_many :followers, through: :passive_follows, source: :user
  has_many :following, through: :active_follows,  source: :follower


  validates :username, presence: true,
   length: {maximum: Settings.user.name.length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
   length: {maximum: Settings.user.email.length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.user.password.length}, allow_nil: true

  has_secure_password

  ratyrate_rater

  mount_uploader :avatar, ImageUploader

  class << self
    def digest string
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def search key
      where("username LIKE ? OR email LIKE ?", "%#{key}%", "%#{key}%")
    end
  end

  def remember
    @remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def current_user? user
    user == self
  end

  def liked? book
    liked.include? book
  end

  def like book
    liked << book
  end

  def unlike book
    liked.destroy book
  end

  def current_like book
    likes.find_by book_id: book.id
  end

  def favorited? book
    favorited.include? book
  end

  def favorite book
    favorited << book
  end

  def current_favorite book
    favorites.find_by book_id: book.id
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end
end
