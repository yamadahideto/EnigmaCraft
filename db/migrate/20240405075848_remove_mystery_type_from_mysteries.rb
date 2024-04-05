class RemoveMysteryTypeFromMysteries < ActiveRecord::Migration[7.1]
  def change
    remove_column :mysteries, :mystery_type, :string
  end
end
