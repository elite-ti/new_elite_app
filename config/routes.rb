EliteApp::Application.routes.draw do
  resources :answer_card_types


  resources :student_exams

  resources :exam_answers
  resources :exams do
    post 'upload_answers', on: :member
  end
  resources :questions
  resources :exam_cycles
  resources :students

  resources :poll_question_types
  resources :poll_question_categories
  resources :poll_pdfs
  resources :polls

  resources :teacher_absences
  resources :teacher_reports

  resources :campus_time_tables
  resources :teacher_time_tables
  resources :klazz_time_tables
  resources :time_tables

  resources :personal_infos
  resources :professional_infos
  resources :schedule_infos

  resources :teachers
  resources :employees

  resources :absence_reasons
  resources :majors
  resources :school_roles
  resources :elite_roles
  resources :klazz_types
  resources :subjects
  resources :subject_threads

  resources :klazzes
  resources :campuses
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
  root to: 'home#index'
end
