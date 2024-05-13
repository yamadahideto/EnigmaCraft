class Mystery < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :genre
  has_many :answers, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true
  validates :image, presence: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp', 'image/HEIF']
  validates :content, presence: true
  validates :correct_answer, presence: true

  def correctly?(current_user_id)
    # 正解済みであればtrueを返却
    answers.exists?(user_id: current_user_id, mystery_id: id, correct_flag: true)
  end
end
