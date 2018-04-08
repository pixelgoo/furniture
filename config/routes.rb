Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  
  root to: 'pages#show', page: 'index'

  %w(help).each do |page|
    get "/pages/${page}", to: 'pages#show', as: page, page: page
  end

  controller :profiles do
    get '/profile' => :show
    get '/settings' => :settings
    get '/account' => :account
  end

  get '/payment/:tariff', to: 'payments#subscribe', as: 'subscribe'
  post '/payment/callback', to: 'payments#callback', as: 'callback'
  
  # Products
  resources :products

  # Requests
  resources :requests
end

ActiveSupport::Notifications.instrument 'routes_loaded.application'