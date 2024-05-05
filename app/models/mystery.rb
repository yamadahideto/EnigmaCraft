class Mystery < ApplicationRecord
  # after_initialize :set_default_value
  has_one_attached :image
  belongs_to :user
  belongs_to :genre
  has_many :answers

  validates :title, presence: true
  validates :image, presence: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp', 'image/HEIF']
  validates :content, presence: true
  validates :correct_answer, presence: true

  # def set_default_value
  #   self.title = 'AI生成'
  #   self.content = 'AI生成'
  # end
end
