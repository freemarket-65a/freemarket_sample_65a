Rails.application.routes.draw do

  root to: 'products#index'

  resources :details

end
