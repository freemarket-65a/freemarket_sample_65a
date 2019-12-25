Rails.application.routes.draw do

  root to: 'products#index'

  resources :products, only: [:index]
  
  resources :users do
    member do
      get 'mypage'
      get 'profile'
      get 'credit'
      get 'logout'
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

end
