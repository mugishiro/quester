Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  root to: 'toppages#index'
  get 'toppages/show'
  get 'toppages/follows'

  resources :users, only: [:show]
  resources :posts, only: [:show, :create, :destroy]
  resources :replies, only: [:create, :destroy]
end
