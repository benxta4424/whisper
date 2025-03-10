Rails.application.routes.draw do
  root "posts#index"

  resources :pages, only: [ :index ]

  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :users, only: [ :new, :create, :index, :show ] do
    resources :posts
  end

  resources :posts do
    resources :likes, only: [ :new, :create, :destroy ]
    resources :comments, only: [ :new, :create ]
  end

  resources :friendships, only: [ :new, :create, :show, :destroy ]




  get "up" => "rails/health#show", as: :rails_health_check
end
