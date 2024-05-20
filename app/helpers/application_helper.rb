module ApplicationHelper
  # AI謎生成中に表示する画像をランダムに取得
  def random_image
    image_number = rand(1..4)
    "nazo#{image_number}.webp"
  end
end
