Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root to: "pages#home"
  # root "articles#index"
  get '/trips/search', to: 'trips#search'
  resources :trips, only: %i[new create index show edit update]
  resources :locations, only: :update
end
