class Mystery < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true
  validates :image, presence: true
  validates :content, presence: true
  validates :correct_answer, presence: true
end
