Rails.application.routes.draw do

  root to: 'pages#show', page: 'index'
  get "/pages/:page" => "pages#show"

end
