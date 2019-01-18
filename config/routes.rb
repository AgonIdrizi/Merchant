Rails.application.routes.draw do
  
  root to: "products#index"
  get '/profile' , to: 'users#profile'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :admin do
      
      resources :users
      resources :addresses
      resources :carts
      resources :orders
      resources :order_items
      resources :products

      root to: "orders#index"
    end
  
  resources :addresses
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth',sessions: 'users/sessions' }
 
  resources :products
  
  resources :order_items
  resources :orders
  resources :carts

  resources :confirms
  post :confirms , to: "confirms#create"


  resources :charges, only: [:new, :create]

end
