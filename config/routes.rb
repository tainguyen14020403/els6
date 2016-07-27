Rails.application.routes.draw do
  root "static_pages#home"
  get "about" => "static_pages#about"
  get "help" => "static_pages#help"
  get "signup" => "users#new"
  post "signup" => "users#create"
  get    "login" => "sessions#new"
  post   "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :categories
  end
  
  resources :users do
    resources :followings, only: [:index]
    resources :followers, only: [:index]
  end
  resources :categories, only: [:index, :show]
  resources :words
  resources :relationships, only: [:create, :destroy]
end
