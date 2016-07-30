class AddCategoryToActivities < ActiveRecord::Migration
  def change
    add_reference :activities, :category, index: true, foreign_key: true
  end
end
