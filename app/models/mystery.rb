class Mystery < ApplicationRecord
  before_validation :set_default_value
  has_one_attached :image
  belongs_to :user
  belongs_to :genre
  has_many :answers, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true
  # validates :image, presence: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp', 'image/HEIF']
  validates :content, presence: true
  validates :correct_answer, presence: true

  def correctly?(current_user_id)
    # 正解済みであればtrueを返却
    answers.exists?(user_id: current_user_id, mystery_id: id, correct_flag: true)
  end

  def set_default_value
    self.content = 'Ai画像生成' if content.blank?
    self.title = 'AI生成' if title.blank?
  end
end
