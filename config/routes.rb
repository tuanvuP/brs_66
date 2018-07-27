Rails.application.routes.draw do
  get "/help", to: "static_pages#help"
  resources :users, only: %i(new create)
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  root "static_pages#home"
end
