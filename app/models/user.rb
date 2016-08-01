class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save {self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id",
    dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id",
    dependent: :destroy
  has_many :following, through: :active_relationships,
    source: :followed
  has_many :followers, through: :passive_relationships,
    source: :follower
  has_many :results
  has_many :activities
  has_many :lessons

  validates :name, presence: true, length: {maximum: Settings.name_length_max}
  validates :email, presence: true, length: {maximum: Settings.email_length_max},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.password_length_min}

  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    Activity.where("user_id = ?", id)
  end
end
