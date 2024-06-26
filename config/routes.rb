Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index'
  get '/auth/google_oauth2/callback', to: 'sessions#create', as: "sessions_create"

  resources :sign_in, only: [:index]
  resources :sessions, only: [:destroy]
  resources :users, only: [:create] do
    resources :libraries, only: [:index] do
      resources :cookbooks, except: [:index] do #is this too long of a route?
        get 'match', on: :new
        resources :recipes, except: [:index]
      end
    end
  end
end
