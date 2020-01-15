Rails.application.routes.draw do
  
  get 'card/new'
  get 'card/show'
  devise_for :users

  root to: 'exhibits#index'
  # root to: 'exhibits#indexfirst'

  # resources :exhibits
  resources :exhibits do
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end

    member do
      get 'buy'
      post 'pay'
      get 'done', to: 'exhibits#index'
    end
  end

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

  get "signup", to: "signup#index"

  resources :signup do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      get 'step4'
      get 'step5'
      get 'complete_signup'
    end
  end

  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end

end
