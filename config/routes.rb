Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :accounts, only: [:create, :update]
end
