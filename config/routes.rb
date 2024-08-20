Rails.application.routes.draw do

    resources :profiles, only: [] do
      collection do
        post 'follow'
        delete 'unfollow'
        post 'accept'
        post 'decline'
        delete 'cancel'
      end
    end


  devise_for :users

  root "homes#index"

  resources :homes

  resources :users

  resources :posts do
    resources :comments
  end

  resources :likes

  resources :stories
end
