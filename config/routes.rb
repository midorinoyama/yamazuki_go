Rails.application.routes.draw do
  devise_for :users
  #deivseを使用するURLにusersを含む
  root to: 'homes#top'
  resources :users, only: [:index, :show, :edit, :update]
  resources :posts do
    resource :favorites, only: [:create, :destroy]
  end
end
