class Answer < ActiveRecord::Base
  belongs_to :word

  def self.create_answer(answer, status, word_id)
    Answer.create(mean: answer, status: status, word_id: word_id)
  end
end
