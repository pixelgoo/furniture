Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
  
  # Root
  root to: 'pages#show', page: 'index'

  # Static pages
  get "/pages/:page" => "pages#show"

  # Users
  # get "profile" => "users#profile"

end
