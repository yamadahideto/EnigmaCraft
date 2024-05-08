class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :mystery
  validates :user_id, uniqueness: { scope: :mystery_id }
end
