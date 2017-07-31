Rails.application.routes.draw do
  get 'course_groups/show'

  get 'course_group_teachers/show'

  root to: 'statics#home'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'signup', to: 'users#new', as: 'signup'

  resources :users
  resource :sessions, only: [:new, :create, :destroy]
  resources :schools do
    resources :courses, :course_groups
    resources :groups do
      resources :enroll, only: [:create], shallow: true
    end
  end
end
