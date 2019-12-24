Rails.application.routes.draw do
  devise_for :users
  # root to: 'users#profile' ←仮で画面確認のため、残しています。
  # root to: 'users#mypage' ←仮で画面確認のため、残しています。
  # root to: 'users#credit' ←仮で画面確認のため、残しています。
  root to: 'products#index'
end
