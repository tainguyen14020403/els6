class Activity < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :user
  belongs_to :category
  
  default_scope -> {order(created_at: :desc)}

  def self.create_activity(category_id, count, user_id)
    Activity.create(category_id: category_id, words_count: count, user_id: user_id)
  end
end
