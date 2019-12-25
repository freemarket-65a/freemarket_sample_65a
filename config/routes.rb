Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'products#index'

  resources :products, only: [:index]

  resources :users, only: [:index] do
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
