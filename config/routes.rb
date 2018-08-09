Rails.application.routes.draw do
  root "books#index"
  get "/help", to: "static_pages#help"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/add_cart/:book_id", to: "carts#add_cart", as: :add_cart
  delete "/remove_book/:book_id", to: "carts#remove_book", as: :remove_book

  namespace :admin do
    resources :authors, except: :destroy
  end

  resources :users, except: :destroy
  resources :books, only: %i(index show)
  resources :carts, only: :index
  resources :carts do
    collection do
      post :update_quantity
    end
  end
  resources :orders
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
  resources :orders, only: %i(index new create destroy)

  namespace :admin do
    resources :books
  end
end
