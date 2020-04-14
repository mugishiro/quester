Rails.application.routes.draw do
  root to: 'toppages#index'
  
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  get 'toppages/show'
  get 'toppages/follows'

  resources :users, only: [:show], param: :nickname do
    resources :posts, only: [:show, :create, :update, :destroy] do
      post :confirm, action: :confirm_new, on: :new
    end
  end
  get 'users/:nickname/closed', to: 'users#closed', as: :closed_posts
  get 'posts/get_image'

  resources :replies, only: [:create, :destroy] do
    post :confirm, action: :confirm_new, on: :new
  end
end
