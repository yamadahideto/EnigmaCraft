class Mystery < ApplicationRecord
  after_initialize :set_default_value
  has_one_attached :image

  validates :title, presence: true
  validates :image, presence: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp', 'image/HEIF']
  validates :content, presence: true
  validates :correct_answer, presence: true
  enum mystery_type: { image: 0, text: 1 }

  private

  def set_default_value
    self.content = 'Ai画像生成'
    self.mystery_type = 'image'
  end
end
