Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :show, :create, :index] do
    resources :comments, :polymorphic => true
  end
  resources :sessions, only: [:new, :create, :destroy]
  # Defines the root path route ("/")
  # root "articles#index"
  resources :goals do
    resources :comments, :polymorphic => true
  end
  resources :comments, only: [:destroy]
  root "sessions#new"
end
