class AddResultToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :result, :integer, default: 0
  end
end
