Rails.application.routes.draw do

  root to: 'products#index'

  resources :users do
    member do
      get 'mypage'
      get 'profile'
      get 'credit'
    end
  end
  resources :details

end
