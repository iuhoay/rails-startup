RailsBootstrap::Application.routes.draw do

  root "users#index"

  get "users/signup"
  get "session/signin"
  get "session/signup"

  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"

  get "signup" => "users#new"
  post "signup" => "users#create"
  get "signin" => "session#new"
  post "signin" => "session#create"
  post "logout" => "session#destroy"

  resources :users
end
