Rails.application.routes.draw do
  resources :products, only: :index

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "products#index"
end
