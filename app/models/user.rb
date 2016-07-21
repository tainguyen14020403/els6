class User < ActiveRecord::Base
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
end
