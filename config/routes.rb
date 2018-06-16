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
    resource :time_slot
    resources :subjects
    resources :assignments
    resources :groups do
      resource :schedule
      resources :courses
      resources :homeworks, only: [:index, :create, :update, :destroy]
      resources :absences, only: [:new, :create, :update, :destroy]
      resources :marks, only: [:new, :create, :update, :destroy]
      resources :student_invitations, path: :students, module: :schools, only: [:new, :create]
      resources :parent_invitations, path: :parents, module: :schools, only: [:new, :create]
    end
    resources :headmaster_invitations, path: :headmasters, module: :schools, only: [:new, :create]
    resources :teacher_invitations, path: :teachers, module: :schools, only: [:new, :create]
    member do 
      get 'dashboard'
    end
  end

  resources :students, only: [] do
    resources :parentship, only: :create, module: :students
  end

  resources :parentship, only: :create
  resources :profiles do
    member do 
      get 'dashboard'
      get 'schedule'
    end  
  end
  resources :messages, only: [:index, :create]

  root 'pages#show', page: 'home'
  get '/pages/*page', to: 'pages#show'
end
