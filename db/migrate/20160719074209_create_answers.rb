class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :mean
      t.integer :status, default: 0
      t.references :word, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
