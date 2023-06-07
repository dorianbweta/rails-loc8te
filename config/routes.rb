Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root to: "pages#home"
  # root "articles#index"
  resources :trips, only: %i[new create index show] do
    resources :rides, only: %i[index]
  end
end
