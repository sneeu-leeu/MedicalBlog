Rails.application.routes.draw do
  devise_for :users,
            controllers: {
              sessions: 'users/sessions',
              registrations: 'users/registrations'
            }

  root 'users#index'

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show] do
        resources :posts, only: %i[index] do
          resources :comments, only: %i[create index]
        end
      end
    end
  end


  resources :users, only: %i[show index] do
    resources :posts, only: %i[show index create new destroy]
  end

  resources :posts do
    resources :comments, only: %i[create new update destroy]
    resources :likes, only: %i[create]
  end
end
