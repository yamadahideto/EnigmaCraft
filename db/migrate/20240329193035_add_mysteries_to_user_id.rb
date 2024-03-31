class AddMysteriesToUserId < ActiveRecord::Migration[7.1]
  def change
    add_reference :mysteries, :user, foreign_key: true
  end
end
