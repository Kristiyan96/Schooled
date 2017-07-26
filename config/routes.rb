Rails.application.routes.draw do
  root to: 'statics#home'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'signup', to: 'users#new', as: 'signup'

  resource :sessions, only: [:new, :create, :destroy]
  resources :schools do
    resources :groups do
      resources :enroll, only: [:create], shallow: true
    end
  end
end
