class Lesson < ActiveRecord::Base
  after_create :update_lesson

  has_many :results
  has_many :activities

  belongs_to :category
  belongs_to :user

  def update_lesson
    @category = Category.find_by(id: self.category_id)
    @words = @category.words.not_learned(user_id).order("RAND()").limit(Settings.max_word_user)
    @words.each do |word|
      Result.create_result(self.user_id, id, word.id)
    end
  end
end
