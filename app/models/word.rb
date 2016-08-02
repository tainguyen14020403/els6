class Word < ActiveRecord::Base
  has_many :results, dependent: :destroy
  has_many :answers, dependent: :destroy

  belongs_to :category

  validates :content, presence: true
  validates :mean, presence: true

  scope :learned, ->(current_user_id){ 
    where("words.id in (select word_id from results where user_id = ?)", current_user_id) }
  scope :not_learned, ->(current_user_id){ 
    where("words.id not in (select word_id from results where user_id = ?)", current_user_id) }
  scope :words_in_lesson, ->(lesson_id){ 
    where("words.id in (select word_id from results where lesson_id = ?)", lesson_id) }
end
