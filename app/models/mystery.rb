class Mystery < ApplicationRecord
  after_initialize :set_default_value
  has_one_attached :image
  belongs_to :user
  belongs_to :genre
  has_many :answers

  validates :title, presence: true
  validates :image, presence: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp', 'image/HEIF']
  validates :content, presence: true
  validates :correct_answer, presence: true

  def create_genre(genres)
    self.genres = Genre.find_or_create_by(name: genres)
  end

  private

  def set_default_value
    self.content = 'Ai画像生成'
  end
end
