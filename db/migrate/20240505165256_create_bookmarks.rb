class CreateBookmarks < ActiveRecord::Migration[7.1]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :mystery, null: false, foreign_key: true
      t.timestamps
      t.index [:user_id, :mystery_id], unique: true
      end
  end
end
