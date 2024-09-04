Rails.application.routes.draw do
  get 'chat_users/create'
  get 'messages/create'
  get 'chats/show'

    resources :profiles, only: [:show] do
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

  get 'search', to: 'homes#search'


  resources :chats do
    resources :messages, param: :chat_id
  end

  get 'start_chat', to: 'chats#start_chat'

end
