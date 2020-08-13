Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:create]

  resources :accounts, only: [:create, :update, :show] do
    member do
      post :deposit
      post :withdraw
      post :transfer
    end
  end
end
