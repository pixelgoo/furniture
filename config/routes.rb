Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  
  # Root
  root to: 'pages#show', page: 'index'

  # Static pages
  %w(help).each do |page|
    get "/pages/${page}", to: 'pages#show', as: page, page: page
  end

  # Profile
  get '/profile', to: 'profiles#show'
  get '/settings', to: 'profiles#settings'
  get '/account', to: 'profiles#account'

  # Tariff payment
  post '/tariff', to: 'payments#tariff_payment', as: 'tariff_payment'

  # Products
  resources :products

  # Requests
  resources :requests

end
