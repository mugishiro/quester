Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'toppages/show'
  get 'toppages/follows'
  get 'toppages/edit'

  devise_for :users, only: [:omniauth_callbacks],
                     controllers: { omniauth_callbacks: "omniauth_callbacks" }
  devise_scope :user do
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
    delete 'registration' => 'devise/registrations#destroy', as: :registration
  end
  resources :users, only: [:show], param: :nickname do
    resources :posts, only: [:show, :create, :update, :destroy] do
      post :confirm, action: :confirm_new, on: :new
    end
  end
  get 'users/:nickname/closed', to: 'users#closed', as: :closed_posts

  resources :replies, only: [:create] do
    post :confirm, action: :confirm_new, on: :new
  end
end
