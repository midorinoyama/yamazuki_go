Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  devise_for :users
  #deivseを使用するURLにusersを含む
  root to: 'homes#top'
  resources :posts
end
