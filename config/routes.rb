Rails.application.routes.draw do
  root "pages#index"
  resources :pages, only: [ :index ]

  devise_for :users
  resources :users, only: [ :show ] do
    resources :friendships, only: [ :new, :create, :show, :destroy ]
  end



  get "up" => "rails/health#show", as: :rails_health_check
end
