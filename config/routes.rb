Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do

    authenticated  do
      root 'profiles#show'
    end

    unauthenticated do
      root to: 'pages#show', page: 'home'
    end
  end

  resources :schools do
    resource :time_slot, except: [:new, :edit]
    resources :subjects, except: [:new, :show, :edit]
    resources :groups do
      resources :homeworks, only: [:index, :create, :update, :destroy]
      resources :absences, only: [:create, :update] do
        member do 
          get 'toggle_category'
          post 'excuse_period'
        end
      end
      resources :marks, only: [:create, :update, :destroy]
      resources :courses
      resource :student_invitations, path: :students, module: :schools, only: [:create] do
        member do 
          get 'students'
        end
      end
      resources :parent_invitations, path: :parents, module: :schools, only: [:index, :create]
      resources :schedules
      member do 
        get 'week_schedule'
        get 'day_schedule'
        get 'marks'
        get 'absences'
      end
    end
    resources :headmaster_invitations, path: :headmasters, module: :schools, only: [:index, :create]
    resource :teacher_invitation, path: :teachers, module: :schools, only: [:create] do
      member do 
        get 'teachers'
      end
    end
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
  resources :contacts, only: [:create]

  get '/pages/*page', to: 'pages#show'
end
