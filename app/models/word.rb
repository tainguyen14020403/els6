class Word < ActiveRecord::Base
  after_create :update_answer

  has_many :results, dependent: :destroy
  has_many :answers, dependent: :destroy

  belongs_to :category

  validates :content, presence: true
  validates :mean, presence: true

  accepts_nested_attributes_for :answers,
    reject_if: lambda {|a| a[:mean].blank?}, allow_destroy: true

  scope :learned, ->(current_user_id){ 
    where("words.id in (select word_id from results where user_id = ?)", current_user_id) }
  scope :not_learned, ->(current_user_id){ 
    where("words.id not in (select word_id from results where user_id = ?)", current_user_id) }
  scope :words_in_lesson, ->(lesson_id){ 
    where("words.id in (select word_id from results where lesson_id = ?)", lesson_id) }

  scope :wrong_answer, ->(word_id){where.not("words.id = ?", word_id)}

  def update_answer
    @category = Category.find_by(id: self.category_id)
    if @category.words.count > Settings.answers_per_word
      @answers = @category.words.wrong_answer(self.id).order("RAND()").limit(Settings.answers_per_word)
      @answers.each do |answer|
        Answer.create_answer(answer.mean, 0, self.id)
      end
    else
      answers = ["Viet Nam", "Viet Nam", "Viet Nam", "Viet Nam"]
      answers.each do |answer|
        Answer.create_answer(answer, 0, self.id)
      end
    end
    self.answers.sample.update_attributes(mean: self.mean, status: 1)
  end
end
