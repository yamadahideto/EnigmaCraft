module ApplicationHelper
  # AI謎生成中に表示する画像をランダムに取得
  def random_image
    image_number = rand(1..4)
    "nazo#{image_number}.webp"
  end

  def show_meta_tags
    set_meta_tags(default_meta_tags)
    display_meta_tags
  end

  def default_meta_tags
    {
      site: 'EnigmaPortals',
      title: '謎解きの作成・共有・回答サービス',
      reverse: true,
      charset: 'utf-8',
      description: 'EnigmaPortalsで誰でも気軽に謎解きを体験できます！。',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('topImage.png'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        title: 'EnigmaPortals 謎クリエイト',
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        site: '@', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
        image: image_url('topImage.png') # 配置するパスやファイル名によって変更すること
      }
    }
  end
end
