Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :products, only: :index
  root "products#index"
end
