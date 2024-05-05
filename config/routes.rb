Rails.application.routes.draw do
  root 'tops#index'
  resources :mysteries do
    collection do
      post 'generate'
      get 'bookmarks'
    end
    resources :answers, only: %i[new create]
    resources :bookmarks, only: %i[create destroy]
  end
  resources :users, only: %i[show new create edit update] do
    collection do
      get 'rankings'
    end
  end
  post 'guestlogin', to: 'user_sessions#guestlogin'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
