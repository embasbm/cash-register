Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :products, only: :index
  resources :carts, only: :destroy
  post 'carts/add_to_cart'

  root "products#index"
end
