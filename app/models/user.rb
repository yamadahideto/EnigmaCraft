class User < ApplicationRecord
  authenticates_with_sorcery!
  has_one_attached :avator do |imagesize|
    imagesize.variant :avatorsize, resize_to_limit: [200, 200]
    # 画像サイズを事前に決めておく
  end
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  # validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true
  # 値が存在することを要求するが、allow_nil: trueによってnilである場合はこの検証をパスする
end
