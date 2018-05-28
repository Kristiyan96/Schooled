Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :schools do
    resources :headmaster_invitations, path: :headmasters, module: :schools, only: [:index, :create]
    resources :teacher_invitations, path: :teachers, module: :schools, only: [:index, :create]
  end

  root "pages#show", page: "home"
  get '/pages/*page', to: 'pages#show'
end
