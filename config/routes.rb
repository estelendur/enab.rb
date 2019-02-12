Rails.application.routes.draw do
  root 'budget#index'
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
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
