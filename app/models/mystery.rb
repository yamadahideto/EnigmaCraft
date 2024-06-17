class Mystery < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :genre
  has_many :answers, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  attr_accessor :ai_generated # AI生成かどうかのフラグ

  validates :title, presence: true, unless: -> { ai_generated? }
  validates :image, presence: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp', 'image/HEIF'], unless: -> { ai_generated? }
  validates :content, presence: true, unless: -> { ai_generated? }
  validates :correct_answer, presence: true

  def generate_content(content)
    self.title = content[:title]
    self.content = content[:content]
    image.attach(
      io: content[:image],
      filename: content[:filename]
    )
  end

  def ai_generated?
    # AI生成時と自作の謎投稿時でのバリデーションの切り替え
    ai_generated
  end

  def correctly?(current_user_id)
    # 正解済みであればtrueを返却
    answers.exists?(user_id: current_user_id, mystery_id: id, correct_flag: true)
  end

  def selfmade?(mystery_id, user_id)
    # 謎の作成者を取得
    Mystery.exists?(id: mystery_id, user_id: user_id)
  end

  # 正解者数をカウント
  def correct_person(mystery_id)
    Answer.where(mystery_id: mystery_id).count
  end
end
