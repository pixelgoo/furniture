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

  # Payments
  get '/payment/:type/:id', to: 'payments#new', as: 'payment'
  post '/payment', to: 'payments#create'
  get '/payment/pending', to: 'payments#pending'

  
  # Products
  resources :products

  # Requests
  resources :requests

end
