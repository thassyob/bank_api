Rails.application.routes.draw do
  resources :users, only: [:create]

  resources :accounts, only: [:create, :update] do
    member do
      post :deposit
      post :withdraw
      post :transfer
    end
  end
end
