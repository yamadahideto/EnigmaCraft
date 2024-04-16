class User < ApplicationRecord
  authenticates_with_sorcery!
  has_one_attached :avator
  has_many :mysteries
  has_many :answers

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  # validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true
  # 値が存在することを要求するが、allow_nil: trueによってnilである場合はこの検証をパスする
  def own?(object)
    id == object&.user_id
  end

  def guest?
    name == 'ゲスト'
  end
end
