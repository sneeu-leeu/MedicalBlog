Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  # Defines the root path route ("/")

  root 'users#index'

  resources :users, only: %i[show index] do
    resources :posts, only: %i[show index create new]
  end

  resources :posts do
    resources :comments, only: %i[create new]
    resources :likes, only: %i[create]
  end
end
