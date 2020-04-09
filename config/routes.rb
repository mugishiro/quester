Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  devise_scope :user do
    root to: 'devise/sessions#new'
  end
  get 'toppages/show'
  get 'toppages/follows'

  resources :users, only: [:show], param: :nickname do
    resources :posts, only: [:show, :create, :update, :destroy] do
      post :confirm, action: :confirm_new, on: :new
    end
  end
  get 'users/:nickname/closed', to: 'users#closed', as: :closed_posts

  resources :replies, only: [:create, :destroy] do
    post :confirm, action: :confirm_new, on: :new
  end
end
