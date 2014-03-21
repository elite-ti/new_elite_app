EliteApp::Application.routes.draw do
  resources :card_processing_upload_statuses do
    member do 
      get :markings
      get :results
      get :scanned
    end    
  end

  resources :attendance_lists
  resources :card_processings
  get 'card_processings/new/:exam_execution_id', to: 'card_processings#new'
  get 'card/:student_ra/:exam_code', to: 'student_exams#card'
  get 'calendar/', to: 'calendar#index'

  get 'exam_executions/', to: 'exam_executions#index'
  get 'exam_executions/:exam_execution_id/result', to: 'exam_executions#result', as: 'result_exam_execution'
  get 'exam_executions/:exam_execution_id/attendance', to: 'exam_executions#attendance', as: 'attendance_exam_execution'
  get 'exam_executions/:exam_execution_id/cards', to: 'exam_executions#cards', as: 'cards_exam_execution'

  resources :topics
  resources :card_types
  resources :student_exams do 
    member do 
      get :error
    end
  end
  get 'student_exams/new/', to: 'student_exams#new'

  resources :exam_answers
  resources :exams do
    member do 
      get :result
    end
    collection do
      post :import
    end
  end 
  resources :questions
  resources :exam_cycles
  resources :applicants
  resources :students do 
    member do 
      get :fix_ra
    end
    collection do
      post :import
    end
  end

  resources :poll_question_types
  resources :poll_question_categories
  resources :poll_pdfs
  resources :polls

  resources :teacher_absences
  resources :teacher_reports

  resources :klazz_calendars

  resources :personal_infos
  resources :professional_infos
  resources :schedule_infos

  resources :teachers do
    resources :periods, controller: 'teacher_periods'
  end
  resources :employees

  resources :absence_reasons
  resources :majors
  resources :school_roles
  resources :elite_roles
  resources :klazz_types
  resources :subjects
  resources :subject_threads

  resources :klazzes do 
    resources :periods, controller: 'klazz_periods'
  end
  
  resources :campuses do 
    resources :periods, controller: 'campuses_periods'
  end
  resources :super_klazzes 
  resources :product_years
  resources :years
  resources :products
  resources :product_groups
  resources :product_types

  get 'change_role/:role', to: 'role_sessions#update'

  match 'auth/google_oauth2/callback', to: 'employee_sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'login_as/:id', to: 'employee_sessions#update', as: 'login_as'
  match 'logout', to: 'employee_sessions#destroy', as: 'logout'

  get 'home', to: 'home#index', as: 'home'
  get "exam_results", to: 'exam_results#index'  
  root to: 'home#index'
end