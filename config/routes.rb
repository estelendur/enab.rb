Rails.application.routes.draw do
  resources :transactions
  resources :accounts do
    resources :transactions
  end
  resources :categories do
    resources :transactions
  end
  get 'budget/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'budget#index'
end
