class CreateAnswers < ActiveRecord::Migration[7.1]
  
  def change
    create_table :answers do |t|
      t.boolean :correct_flag, null: false
      t.references :user, null: false, foreign_key: true
      t.references :mystery, null: false, foreign_key: true
      t.timestamps
    end
  end
end
