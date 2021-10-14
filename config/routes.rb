Rails.application.routes.draw do
  devise_for :users
  #deivseを使用するURLにusersを含む
  root to: 'homes#top'
  resources :posts
end
