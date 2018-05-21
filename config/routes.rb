Rails.application.routes.draw do
  root "pages#show", page: "home"

  resources :schools
  
  get 'sessions/new'
	root "pages#show", page: "home"
	get '/pages/*page', to: 'pages#show'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
