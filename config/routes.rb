Rails.application.routes.draw do
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/home", to: "static_pages#home"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "sessions/new"
  get "password_resets/new"
  get "password_resets/edit"
  resources :users
  resources :account_activations, only: :edit
  resources :password_resets, except: [:index, :destroy, :show]
end
