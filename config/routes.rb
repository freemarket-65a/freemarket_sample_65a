Rails.application.routes.draw do
  
  devise_for :users
  # root to: 'users#profile' ←仮で画面確認のため、残しています。
  # root to: 'users#mypage' ←仮で画面確認のため、残しています。
  # root to: 'users#credit' ←仮で画面確認のため、残しています。

  root to: 'products#index'

  resources :products, only: [:index]
  
  resources :users do
    member do
      get 'mypage'
      get 'profile'
      get 'credit'
      get 'logout'
      get 'identification'
    end
  end

  resources :registration, only: [:index, :new] do
    member do
      get 'address'
      get 'complete'
      get 'login'
      get 'member'
      get 'payment'
      get 'telephone'
    end
  end
  resources :details, only: [:index]
  
  resources :exhibit, only: [:index, :show]

  resources :purchase, only: [:index, :show]

end
