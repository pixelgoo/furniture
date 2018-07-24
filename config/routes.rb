Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  
  root to: 'pages#index'


  # Static pages
  get "/privacy", to: 'pages#privacy'
  get "/offert", to: 'pages#offert'
  get "/help", to: 'pages#help'
  get "/terms", to: 'pages#terms'

  controller :profiles do
    get '/profile' => :show
    patch '/upload_documents' => :upload_documents
    patch '/update_setting' => :update_setting
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