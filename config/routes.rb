Rails.application.routes.draw do
  devise_for :users
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
  end
end
