Rails.application.routes.draw do
  
  resources :addresses
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth',sessions: 'users/sessions' }
  resources :products
  root to: "products#index"
  resources :order_items
  resources :orders
  resources :carts

  
  get :confirm , to: "orders#confirm"

  namespace :checkouts do
    get 'shipping_address'
    get 'billing_address'
  end

  resources :charges

end
