Rails.application.routes.draw do
  root "books#index"
  get "/help", to: "static_pages#help"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    resources :authors, except: :destroy
  end

  resources :users, except: %i(destroy show)
  resources :books, only: %i(index show)
  resources :categories
  resources :comments
  resources :comments do
    member do
      get :new_reply
    end
  end
  resources :likes, expect: :index
  post "/rate", to: "rater#create", as: "rate"
  resources :mark_books, only: %i(create update)
  resources :favorites
end
