class CreateAnswers < ActiveRecord::Migration[7.1]
  
  def change
    create_table :answers do |t|
      t.boolean :correct_flag, null: false
      t.references :user
      t.references :mystery
      t.timestamps
    end
  end
end
