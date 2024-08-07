Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :users

  resources :comments

  resources :posts
end
