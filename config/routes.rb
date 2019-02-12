Rails.application.routes.draw do
  resources :users
  resources :transactions
  resources :accounts do
    resources :transactions
  end
  resources :categories do
    resources :transactions
  end
  get 'budget/index'
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/users/:id', to: 'budget#index'
  root 'budget#index'
end
