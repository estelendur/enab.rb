Rails.application.routes.draw do
  get 'users/new'
  resources :transactions
  resources :accounts do
    resources :transactions
  end
  resources :categories do
    resources :transactions
  end
  get 'budget/index'
  get '/register', to: 'users#new'
  root 'budget#index'
end
