Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/', to: 'welcome#index'
  get '/auth/google_oauth2/callback', to: 'sessions#create'

  resources :sign_in, only: [:index]
  resources :users, only: [:index, :create] do
    resources :libraries, only: [:index] do
      resources :cookbooks, only: [:new, :create] do #is this too long of a route?
        get 'match', on: :new
      end
    end
  end
end
