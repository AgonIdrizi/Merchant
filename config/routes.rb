Rails.application.routes.draw do
  
  resources :addresses
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth',sessions: 'users/sessions' }
  resources :products
  root to: "products#index"
  resources :order_items
  resources :orders

  resources :orders do
    member do
      get :confirm
    end
  end

  resources :charges

end
