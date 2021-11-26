Rails.application.routes.draw do
  devise_for :users
  # deivseを使用するURLにusersを含む
  root to: 'homes#top'
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    member do # URLにuserを認識するidがつく、collectionはidがつかない
      get 'followings'
      get 'followers'
      get 'favorites'
    end
    resource :relationships, only: [:create, :destroy]
  end

  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get '/search' => 'searches#search'
  get '/ranks' => 'ranks#rank'
end
