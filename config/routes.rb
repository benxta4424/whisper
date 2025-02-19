Rails.application.routes.draw do
  root "posts#index"

  resources :pages, only: [ :index ]

  devise_for :users

  resources :users, only: [ :new, :create, :index, :show ] do
    resources :posts
  end

  resources :friendships, only: [ :new, :create, :show, :destroy ]


  resources :likes, only: [ :new, :create, :show ]

  get "up" => "rails/health#show", as: :rails_health_check
end
