class AddPointToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :point, :integer, null: false, default: 0
  end
end
