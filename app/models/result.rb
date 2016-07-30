class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  belongs_to :word
  
  def self.create_result user_id, lesson_id, word_id
    Result.create(user_id: user_id, lesson_id: lesson_id, word_id: word_id)
  end
end
