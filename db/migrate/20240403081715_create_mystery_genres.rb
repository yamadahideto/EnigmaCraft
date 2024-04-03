class CreateMysteryGenres < ActiveRecord::Migration[7.1]
  def change
    create_table :mystery_genres do |t|
      t.references :mystery, null: false, foreign_key: true 
      t.references :genre, null: false, foreign_key: true
      t.timestamps
    end
  end
end
