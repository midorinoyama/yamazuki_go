Rails.application.routes.draw do
  devise_for :users
  # deivseを使用するURLにusersを含む
  root to: 'homes#top'
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  end
  get 'users/:id/followings' => 'users#followings', as: 'followings'
  get 'users/:id/followers' => 'users#followers', as: 'followers'
  get 'users/:id/favorites' => 'users#favorites', as: 'favorites'

  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get '/search' => 'searches#search'
  get '/ranks' => 'ranks#rank'
end
