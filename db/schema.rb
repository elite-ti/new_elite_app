# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140619232421) do

  create_table "absence_reasons", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", :force => true do |t|
    t.integer  "addressable_id"
    t.integer  "addressable_type"
    t.string   "complement"
    t.string   "number"
    t.string   "street"
    t.string   "suburb"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "cep"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", :force => true do |t|
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answer_card_types", :force => true do |t|
    t.string   "name",                  :null => false
    t.string   "parameters",            :null => false
    t.string   "card",                  :null => false
    t.integer  "student_number_length", :null => false
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "answer_card_types", ["name"], :name => "index_answer_card_types_on_name", :unique => true

  create_table "applicants", :force => true do |t|
    t.integer  "number"
    t.string   "bolsao_id"
    t.datetime "subscription_datetime"
    t.datetime "exam_datetime"
    t.integer  "exam_campus_id"
    t.integer  "student_id"
    t.integer  "super_klazz_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "group_name"
  end

  create_table "campus_head_teacher_campuses", :force => true do |t|
    t.integer  "campus_head_teacher_id"
    t.integer  "campus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campus_head_teacher_products", :force => true do |t|
    t.integer  "campus_head_teacher_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campus_head_teachers", :force => true do |t|
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campus_preferences", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "campus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campus_principal_campuses", :force => true do |t|
    t.integer  "campus_principal_id"
    t.integer  "campus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campus_principals", :force => true do |t|
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campuses", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "erp_code"
  end

  create_table "card_processings", :force => true do |t|
    t.integer  "campus_id"
    t.integer  "card_type_id"
    t.string   "name"
    t.string   "file"
    t.date     "exam_date"
    t.boolean  "is_bolsao"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "exam_execution_id"
    t.integer  "employee_id"
  end

  create_table "card_types", :force => true do |t|
    t.string   "name"
    t.string   "parameters"
    t.string   "card"
    t.string   "student_coordinates"
    t.string   "command"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_exam_code"
  end

  create_table "elite_roles", :force => true do |t|
    t.string   "name"
    t.integer  "school_role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", :force => true do |t|
    t.string   "email"
    t.integer  "elite_id"
    t.string   "uid"
    t.integer  "person_id"
    t.date     "date_of_admission"
    t.integer  "elite_role_id"
    t.string   "contract_type"
    t.string   "workload"
    t.string   "cost_per_hour"
    t.string   "pis_pasep"
    t.string   "working_paper_number"
    t.integer  "roles_mask"
    t.string   "name"
    t.string   "photo"
    t.date     "date_of_birth"
    t.string   "gender"
    t.string   "marital_status"
    t.string   "suburb"
    t.string   "city"
    t.string   "state"
    t.string   "personal_email"
    t.string   "identification"
    t.string   "expeditor"
    t.string   "cpf"
    t.string   "cellphone"
    t.string   "alternative_cellphone"
    t.string   "telephone"
    t.string   "alternative_telephone"
    t.string   "contact_telephone"
    t.string   "contact_name"
    t.string   "chapa"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enrollments", :force => true do |t|
    t.integer  "student_id"
    t.integer  "super_klazz_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "erp_code"
    t.string   "status"
  end

  create_table "error_logs", :force => true do |t|
    t.integer  "campus_id"
    t.integer  "error_code",                       :default => -1
    t.string   "message",          :limit => 200
    t.string   "trace",            :limit => 800
    t.string   "full_description", :limit => 1024
    t.datetime "event_time",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  create_table "exam_answers", :force => true do |t|
    t.integer  "student_exam_id"
    t.integer  "exam_question_id"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exam_answers", ["student_exam_id"], :name => "index_exam_answers_on_student_exam_id"

  create_table "exam_cycles", :force => true do |t|
    t.string   "name"
    t.boolean  "is_bolsao"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "product_year_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exam_executions", :force => true do |t|
    t.integer  "exam_cycle_id"
    t.integer  "super_klazz_id"
    t.integer  "exam_id"
    t.datetime "datetime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "exam_code"
  end

  create_table "exam_questions", :force => true do |t|
    t.integer  "question_id"
    t.integer  "exam_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exam_subjects", :force => true do |t|
    t.integer  "subject_id"
    t.integer  "exam_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exams", :force => true do |t|
    t.string   "name"
    t.string   "correct_answers"
    t.integer  "options_per_question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "erp_code"
    t.string   "subjects"
    t.datetime "exam_datetime"
    t.integer  "code"
  end

  create_table "klazz_periods", :force => true do |t|
    t.integer  "teaching_assignment_id"
    t.integer  "klazz_type_id"
    t.integer  "position"
    t.date     "date"
    t.integer  "linked_klazz_period"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "klazz_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "klazzes", :force => true do |t|
    t.string   "name"
    t.integer  "super_klazz_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "majors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mini_exams", :force => true do |t|
    t.integer  "exam_id"
    t.integer  "subject_id"
    t.integer  "options_per_question"
    t.string   "correct_answers"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "order"
  end

  create_table "names", :force => true do |t|
    t.text     "itens"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operators", :force => true do |t|
    t.integer "employee_id"
  end

  create_table "options", :force => true do |t|
    t.integer  "question_id"
    t.string   "letter"
    t.text     "answer"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "periods", :force => true do |t|
    t.integer  "klazz_id"
    t.integer  "subject_id"
    t.integer  "teacher_id"
    t.integer  "position"
    t.date     "date"
    t.integer  "klazz_type_id"
    t.integer  "replaced_id"
    t.integer  "absence_reason_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poll_answers", :force => true do |t|
    t.integer  "poll_question_id"
    t.integer  "grade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poll_pdfs", :force => true do |t|
    t.integer  "klazz_id"
    t.integer  "poll_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poll_question_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poll_question_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poll_questions", :force => true do |t|
    t.integer  "poll_pdf_id"
    t.integer  "poll_question_type_id"
    t.integer  "poll_question_category_id"
    t.integer  "teacher_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "polls", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_group_preferences", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "product_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "preference"
  end

  create_table "product_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_head_teacher_products", :force => true do |t|
    t.integer  "product_head_teacher_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_head_teachers", :force => true do |t|
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_principal_products", :force => true do |t|
    t.integer  "product_principal_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_principals", :force => true do |t|
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_years", :force => true do |t|
    t.string   "name"
    t.integer  "year_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "erp_code"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "product_type_id"
    t.integer  "product_group_id"
    t.string   "prefix"
    t.string   "suffix"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "professional_experiences", :force => true do |t|
    t.integer  "school_role_id"
    t.string   "school_name"
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_topics", :force => true do |t|
    t.integer  "question_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.text     "stem"
    t.text     "model_answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "school_roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_exams", :force => true do |t|
    t.integer  "card_processing_id"
    t.integer  "student_id"
    t.integer  "exam_execution_id"
    t.string   "card"
    t.string   "status"
    t.string   "student_number"
    t.string   "string_of_answers"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grades"
    t.string   "exam_answer_as_string"
    t.string   "exam_code"
  end

  create_table "students", :force => true do |t|
    t.string   "name"
    t.integer  "ra"
    t.string   "email"
    t.string   "password_digest"
    t.string   "cpf"
    t.string   "own_cpf"
    t.string   "rg"
    t.string   "rg_expeditor"
    t.string   "gender"
    t.datetime "date_of_birth"
    t.integer  "number_of_children"
    t.string   "mother_name"
    t.string   "father_name"
    t.string   "telephone"
    t.string   "cellphone"
    t.string   "previous_school"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cod_turma"
    t.string   "status"
  end

  create_table "subject_head_teacher_products", :force => true do |t|
    t.integer  "subject_head_teacher_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subject_head_teacher_subjects", :force => true do |t|
    t.integer  "subject_head_teacher_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subject_head_teachers", :force => true do |t|
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subject_thread_topics", :force => true do |t|
    t.integer  "subject_thread_id"
    t.integer  "topic_id"
    t.integer  "number_of_periods"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subject_threads", :force => true do |t|
    t.integer  "subject_id"
    t.integer  "product_year_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "super_klazzes", :force => true do |t|
    t.integer  "product_year_id"
    t.integer  "campus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teached_subjects", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teacher_absences", :force => true do |t|
    t.integer  "klazz_period_id"
    t.integer  "teacher_id"
    t.integer  "subject_id"
    t.integer  "klazz_type_id"
    t.integer  "absence_reason_id"
    t.boolean  "excused"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", :force => true do |t|
    t.integer  "employee_id"
    t.string   "nickname"
    t.integer  "morning"
    t.integer  "afternoon"
    t.integer  "evening"
    t.boolean  "saturday_moning"
    t.boolean  "saturday_afternoon"
    t.boolean  "sunday_morning"
    t.boolean  "sunday_afternoon"
    t.boolean  "administrative_job"
    t.boolean  "agree_with_terms"
    t.boolean  "graduated"
    t.integer  "major_id"
    t.string   "institute"
    t.boolean  "bachelor"
    t.boolean  "cref"
    t.string   "time_teaching"
    t.boolean  "post_graduated"
    t.string   "post_graduated_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_tablet"
    t.integer  "wanted_workload"
    t.text     "observations"
    t.string   "availability"
  end

  create_table "teaching_assignments", :force => true do |t|
    t.integer  "klazz_id"
    t.integer  "teacher_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticks", :force => true do |t|
    t.integer  "period_id"
    t.integer  "subject_thread_topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_tables", :force => true do |t|
    t.integer  "teaching_assignment_id"
    t.integer  "klazz_type_id"
    t.integer  "position"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "linked_time_table"
  end

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.text     "subtopics"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "update_commands", :force => true do |t|
    t.integer  "campus_id"
    t.string   "sql_command",    :limit => 2048
    t.string   "custom_message", :limit => 200
    t.datetime "update_time"
    t.datetime "updated_at",                     :null => false
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type"
    t.integer  "item_id"
    t.string   "event"
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  create_table "year_products", :force => true do |t|
    t.string   "name"
    t.string   "year_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "years", :force => true do |t|
    t.integer  "number"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
