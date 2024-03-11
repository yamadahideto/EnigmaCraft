class Mystery < ApplicationRecord
  has_one_attached :image do |imagesize|
    imagesize.variant :indexsize, resize_to_limit: [200, 200]
    # 画像サイズを事前に決めておく
  end
  validates :title, presence: true
  validates :image, presence: true
  validates :content, presence: true
  validates :correct_answer, presence: true
end
