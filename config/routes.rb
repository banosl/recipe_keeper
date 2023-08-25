Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/', to: 'welcome#index'

  resources :users, only: [:index, :create] do
    resources :libraries, only: [:index]
  end
end
