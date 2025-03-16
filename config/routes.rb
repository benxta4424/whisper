Rails.application.routes.draw do
  resources :chat_rooms
  resources :messages
  root "posts#index"

  resources :pages, only: [ :index ]

  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :users, only: [ :new, :create, :index, :show, :update ] do
    resources :posts
    resources :friendships, only: [ :new, :create, :destroy ]
  end

  resources :posts do
    resources :likes, only: [ :new, :create, :destroy ]
    resources :comments, only: [ :new, :create ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
