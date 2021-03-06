Rails.application.routes.draw do
  root "users#index"

  get "signup" => "users#new"
  post "signup" => "users#create"
  get "signin" => "session#new"
  post "signin" => "session#create"
  delete "logout" => "session#destroy"

  get "~:name" => "users#show", as: :user

  get "account/edit" => "account#edit", as: :edit_account
  put "account" => "account#update"

  namespace :admin do
    root "users#index"
    resources :users, only: [:index, :destroy]
  end
end
