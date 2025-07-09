Rails.application.routes.draw do
  devise_for :users
  resources :categories do
    resources :tasks, only: [:create, :edit, :update, :destroy]
  end
  root 'categories#index'
end