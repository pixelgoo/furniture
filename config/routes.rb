Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  
  # Root
  root to: 'pages#show', page: 'index'

  # Static pages
  get '/pages/:page', to: 'pages#show'

  # Profile
  get '/profile/home', to: 'profiles#show'

  scope :profile do
    get '/account', to: 'accounts#show'
    get '/settings', to: 'profiles#settings'
  end

  # Products
  resources :products

  # Requests
  resources :requests

end
