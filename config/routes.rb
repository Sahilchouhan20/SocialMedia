Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :users

  resources :posts do
    resources :comments
  end

  resources :stories
end
