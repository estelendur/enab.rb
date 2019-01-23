Rails.application.routes.draw do
  resources :transactions
  resources :accounts
  resources :categories
  get 'budget/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
