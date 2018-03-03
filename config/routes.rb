Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "users/registrations" }
  
  root to: 'pages#show', page: 'index'
  get "/pages/:page" => "pages#show"

end
