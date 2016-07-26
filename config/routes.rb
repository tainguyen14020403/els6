Rails.application.routes.draw do
  root "static_pages#home"
  get "about" => "static_pages#about"
  get "help" => "static_pages#help"
  get "signup" => "users#new"
  post "signup" => "users#create"
  get    "/login" => "sessions#new"
  post   "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"
  get "newwords" => "words#new"
  get "wordlist" => "words#index"
  post "newword" => "words#create"
  resources :users
  resources :words, only: [:new, :edit, :destroy]
end
