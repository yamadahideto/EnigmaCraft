Rails.application.routes.draw do
  root 'tops#index'
  resources :mysteries do
    resources :answers, only: [:new, :create]
  end
  resources :users, only: [:new, :create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
