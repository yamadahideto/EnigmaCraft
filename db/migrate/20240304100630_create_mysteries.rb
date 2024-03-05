class CreateMysteries < ActiveRecord::Migration[7.1]
  def change
    create_table :mysteries do |t|
      t.string :title, null: false
      t.integer :mystery_type, null: false
      t.string :content, null: false
      t.string :correct_answer, null: false
      t.timestamps
    end
  end
end
