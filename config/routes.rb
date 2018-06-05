Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  
  root to: 'pages#show', page: 'index'

  %w(help).each do |page|
    get "/pages/${page}", to: 'pages#show', as: page, page: page
  end

  controller :profiles do
    get '/profile' => :show
    get '/settings' => :settings
    patch '/upload_documents' => :upload_documents
  end

  get '/payment/:tariff', to: 'payments#subscribe', as: 'subscribe'
  post '/payment/callback', to: 'payments#callback', as: 'callback'

  # Products
  resources :products

  # Filters API
  get '/filters/furnitures', to: 'filters#furnitures'
  get '/filters/categories', to: 'filters#categories'
  get '/filters/features', to: 'filters#features'

  # Requests
  get '/requests/:status', to: 'requests#index', as: 'requests'
  resources :requests, only: [:create, :update]
end

ActiveSupport::Notifications.instrument 'routes_loaded.application'