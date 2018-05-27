Rails.application.routes.draw do
  devise_for :users
  resources :schools

  root "pages#show", page: "home"
	get '/pages/*page', to: 'pages#show'
end
