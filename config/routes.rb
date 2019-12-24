Rails.application.routes.draw do

  # ↓作成途中のため、仮で残しています。
  # root to: 'users#profile'
  # root to: 'users#mypage'
  # root to: 'users#credit_p'
  # root to: 'users#credit'

  root to: 'products#index'

  # ↓作成途中のため、仮で残しています。
  # resources :products

  resources :users
  resources :details

end
