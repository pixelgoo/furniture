Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  
  # Root
  root to: 'pages#show', page: 'index'

  # Static pages
  get '/pages/:page', to: 'pages#show'

  # Profile
  get '/profile', to: 'profiles#show'

end
