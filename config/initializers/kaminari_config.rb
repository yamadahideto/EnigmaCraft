Kaminari.configure do |config|
  # 表示する最初と最後のページ数
  config.window = 1
  # 左右に表示するページ数
  config.outer_window = 0
  # 省略記号の前後に表示するページ数
  config.left = 1
  config.right = 1
end