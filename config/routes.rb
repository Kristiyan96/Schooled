Rails.application.routes.draw do
  devise_for :users, skip: :registrations
  devise_scope :user do
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: 'users',
      path_names: { new: 'sign_up' },
      controller: 'registrations',
      as: :user_registration do
        get :cancel
      end
  end

  resources :schools do
    resources :groups do
      resources :homeworks, only: [:index, :create, :update, :destroy]
      resources :absences, only: [:index, :create, :update]
      resources :marks
      resources :courses
      resources :student_invitations, path: :students, module: :schools, only: [:index, :create]
      resources :parent_invitations, path: :parents, module: :schools, only: [:index, :create]
    end
    resources :headmaster_invitations, path: :headmasters, module: :schools, only: [:index, :create]
    resources :teacher_invitations, path: :teachers, module: :schools, only: [:index, :create]
  end

  resources :students, only: [] do
    resources :parentship, only: :create, module: :students
  end

  resources :parentship, only: :create
  resources :profiles

  root 'pages#show', page: 'home'
  get '/pages/*page', to: 'pages#show'
end
