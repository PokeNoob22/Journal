Rails.application.routes.draw do
  # Devise authentication routes
  devise_for :users

  # Categories resources (fully RESTful)
  resources :categories do
    # Will add tasks nested here later
    # resources :tasks, shallow: true
  end

  # Root route
  root 'categories#index'

  # Error handling for incorrect routes
  match '*unmatched', to: 'application#route_not_found', via: :all
end