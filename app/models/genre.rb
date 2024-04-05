class Genre < ApplicationRecord
  has_many :mysteries, dependent: :destroy

  validates :name, presence: true
end
