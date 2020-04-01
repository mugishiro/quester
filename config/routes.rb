Rails.application.routes.draw do
  get 'posts/create'
  get 'posts/destroy'
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  root to: 'toppages#index'
  get 'toppages/index'
  get 'toppages/show'
  get 'toppages/follows'

  resources :users, only: [:show]
  resources :posts, only: [:create, :destroy]
end
