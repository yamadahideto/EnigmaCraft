Rails.application.routes.draw do
  root 'tops#index'
  get 'privacy', to: 'tops#privacy'
  get 'terms', to: 'tops#terms'
  resources :mysteries do
    collection do
      post 'generate'
      get 'bookmarks'
    end
    resources :answers, only: %i[new create]
  end
  resources :bookmarks, only: %i[create destroy]
  resources :users, only: %i[show new create edit update] do
    collection do
      get 'rankings'
    end
  end
  # ゲストログイン
  post 'guestlogin', to: 'user_sessions#guestlogin'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  # Oouth認証ルーティング
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  # 未定義のルーティングにアクセス時にルートにリダイレクト
  match '*path', to: redirect('/'), via: :all, constraints: lambda { |req|
    !req.path.starts_with?('/rails/active_storage')
  }
end
