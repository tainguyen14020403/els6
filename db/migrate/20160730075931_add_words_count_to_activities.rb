class AddWordsCountToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :words_count, :integer
  end
end
