Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'static_pages#index'

  as :user do
    get  'signin', to: 'devise/sessions#new'
    post 'signin', to: 'devise/sessions#create'
    get  'signup', to: 'devise/registrations#new'
    post 'signup', to: 'devise/registrations#create'
  end
  resources :users
  resources :posts do
    resources :comments
    resources :likes, only: [:create, :destroy]
  end
  resources :friendship_requests,  only: [:create, :destroy]
  resources :friendships,          only: [:create, :destroy]
end
