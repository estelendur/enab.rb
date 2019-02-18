# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
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
end
