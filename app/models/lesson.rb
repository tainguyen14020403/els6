class Lesson < ActiveRecord::Base
  has_many :results
  has_many :activities

  belongs_to :category
  belongs_to :user
end
