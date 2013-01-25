namespace :db do
  namespace :populate do
    
    task general: [
      :product_types, :product_groups, :products, :years, :campuses, 
      :klazzes, :subjects, :klazz_types, :majors, :school_roles, 
      :elite_roles, :absence_reasons, :employees, :teachers, :admins, 
      :poll_question_types, :poll_question_categories
    ]

    task exam_related: [:answer_card_type, :exam_cycle, :questions, :exam]

    task and_go_grab_a_coffee: [:time_tables, :teacher_photos]

  end
end
