class Mystery < ApplicationRecord
  validates :title, presence: true
  validates :mystery_type, presence: true
  validates :content, presence: true
  validates :correct_answer, presence: true
end
