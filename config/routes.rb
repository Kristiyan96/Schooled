Rails.application.routes.draw do
  get 'sessions/new'
  root "pages#show", page: "home"

  get '/pages/*page' => 'pages#show'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
