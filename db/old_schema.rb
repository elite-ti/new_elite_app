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

ActiveRecord::Schema.define(:version => 20121219191042) do

  create_table "absence_reasons", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "absence_reasons", ["name"], :name => "index_absence_reasons_on_name", :unique => true

  create_table "admins", :force => true do |t|
    t.integer  "employee_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "admins", ["employee_id"], :name => "index_admins_on_employee_id", :unique => true

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.integer  "grade"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "campus_head_teacher_campuses", :force => true do |t|
    t.integer  "campus_head_teacher_id"
    t.integer  "campus_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "campus_head_teacher_campuses", ["campus_head_teacher_id", "campus_id"], :name => "campus_head_teacher_campuses_cht_id_c_id", :unique => true

  create_table "campus_head_teacher_products", :force => true do |t|
    t.integer  "campus_head_teacher_id"
    t.integer  "product_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "campus_head_teacher_products", ["campus_head_teacher_id", "product_id"], :name => "campus_head_teacher_products_chtid_pid", :unique => true

  create_table "campus_head_teachers", :force => true do |t|
    t.integer  "employee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "campus_preferences", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "campus_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "campus_preferences", ["campus_id", "teacher_id"], :name => "campus_preferences_c_id_t_id", :unique => true

  create_table "campus_principals", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "campus_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "campuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "campuses", ["name"], :name => "index_campuses_on_name", :unique => true

  create_table "delay_reasons", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "delay_reasons", ["name"], :name => "index_delay_reasons_on_name", :unique => true

  create_table "elite_roles", :force => true do |t|
    t.string   "name",           :null => false
    t.integer  "school_role_id", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "elite_roles", ["name"], :name => "index_elite_roles_on_name", :unique => true

  create_table "employees", :force => true do |t|
    t.string   "email"
    t.string   "elite_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
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
    t.string   "address"
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
  end

  add_index "employees", ["elite_id"], :name => "index_employees_on_elite_id", :unique => true
  add_index "employees", ["email"], :name => "index_employees_on_email", :unique => true
  add_index "employees", ["uid"], :name => "index_employees_on_uid", :unique => true

  create_table "klazz_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "klazz_types", ["name"], :name => "index_klazz_types_on_name", :unique => true

  create_table "klazzes", :force => true do |t|
    t.string   "name"
    t.integer  "year_id"
    t.integer  "campus_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "klazzes", ["name", "year_id"], :name => "index_klazzes_on_name_and_year_id", :unique => true

  create_table "majors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "majors", ["name"], :name => "index_majors_on_name", :unique => true

  create_table "pdfs", :force => true do |t|
    t.integer  "klazz_id"
    t.integer  "poll_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "photo"
    t.date     "date_of_birth"
    t.string   "gender"
    t.string   "marital_status"
    t.string   "address"
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
    t.boolean  "graduated"
    t.integer  "major_id"
    t.string   "institute"
    t.boolean  "bachelor"
    t.boolean  "cref"
    t.string   "time_teaching"
    t.boolean  "post_graduated"
    t.string   "post_graduated_comment"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "roles_mask"
  end

  create_table "polls", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "product_group_preferences", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "product_group_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "preference",       :null => false
  end

  add_index "product_group_preferences", ["product_group_id", "teacher_id"], :name => "product_group_preferences_pg_id_t_id", :unique => true

  create_table "product_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "product_groups", ["name"], :name => "index_product_groups_on_name", :unique => true

  create_table "product_head_teacher_products", :force => true do |t|
    t.integer  "product_head_teacher_id"
    t.integer  "product_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "product_head_teacher_products", ["product_head_teacher_id", "product_id"], :name => "product_head_teacher_products_phtid_pid", :unique => true

  create_table "product_head_teachers", :force => true do |t|
    t.integer  "employee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "product_principals", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "product_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "product_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "product_types", ["name"], :name => "index_product_types_on_name", :unique => true

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "product_type_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "product_group_id"
  end

  add_index "products", ["name", "product_type_id"], :name => "index_products_on_name_and_product_type_id", :unique => true

  create_table "professional_experiences", :force => true do |t|
    t.integer  "school_role_id", :null => false
    t.string   "school_name",    :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "teacher_id"
  end

  create_table "question_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "question_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.integer  "pdf_id"
    t.integer  "question_type_id"
    t.integer  "question_category_id"
    t.integer  "teacher_id"
    t.integer  "number"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "schedules", :force => true do |t|
    t.string   "name"
    t.integer  "year_subject_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "school_roles", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "school_roles", ["name"], :name => "index_school_roles_on_name", :unique => true

  create_table "subject_head_teacher_products", :force => true do |t|
    t.integer  "subject_head_teacher_id"
    t.integer  "product_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "subject_head_teacher_products", ["subject_head_teacher_id", "product_id"], :name => "subject_head_teacher_products_sht_id_p_id", :unique => true

  create_table "subject_head_teacher_subjects", :force => true do |t|
    t.integer  "subject_head_teacher_id"
    t.integer  "subject_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "subject_head_teacher_subjects", ["subject_head_teacher_id", "subject_id"], :name => "subject_head_teacher_subjects_sht_id_s_id", :unique => true

  create_table "subject_head_teachers", :force => true do |t|
    t.integer  "employee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "subjects", ["code"], :name => "index_subjects_on_code", :unique => true
  add_index "subjects", ["name"], :name => "index_subjects_on_name", :unique => true
  add_index "subjects", ["short_name"], :name => "index_subjects_on_short_name", :unique => true

  create_table "teached_subjects", :force => true do |t|
    t.integer  "teacher_id", :null => false
    t.integer  "subject_id", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "teached_subjects", ["teacher_id", "subject_id"], :name => "index_teached_subjects_on_teacher_id_and_subject_id", :unique => true

  create_table "teacher_absences", :force => true do |t|
    t.integer  "time_table_id"
    t.integer  "absence_reason_id"
    t.integer  "teacher_id"
    t.boolean  "delay"
    t.integer  "delay_in_minutes"
    t.boolean  "excused"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "subject_id"
    t.integer  "klazz_type_id"
  end

  add_index "teacher_absences", ["time_table_id"], :name => "index_teacher_absences_on_time_table_id", :unique => true

  create_table "teachers", :force => true do |t|
    t.integer  "employee_id"
    t.string   "nickname"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
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
  end

  add_index "teachers", ["employee_id"], :name => "index_teachers_on_employee_id", :unique => true

  create_table "teaching_assignments", :force => true do |t|
    t.integer  "klazz_id"
    t.integer  "teacher_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "subject_id"
  end

  create_table "ticks", :force => true do |t|
    t.integer  "klazz_id"
    t.integer  "topic_id"
    t.integer  "delay_reason_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "ticks", ["klazz_id", "topic_id"], :name => "index_ticks_on_klazz_id_and_topic_id", :unique => true

  create_table "time_table_ticks", :force => true do |t|
    t.integer  "time_table_id"
    t.integer  "tick_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "time_table_ticks", ["time_table_id", "tick_id"], :name => "index_time_table_ticks_on_time_table_id_and_tick_id", :unique => true

  create_table "time_tables", :force => true do |t|
    t.integer  "teaching_assignment_id"
    t.integer  "weight"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "position"
    t.integer  "klazz_type_id"
    t.date     "date"
    t.integer  "linked_time_table"
  end

  create_table "topics", :force => true do |t|
    t.integer  "schedule_id"
    t.string   "name"
    t.integer  "weight"
    t.text     "itens"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "topics", ["name", "schedule_id"], :name => "index_topics_on_name_and_schedule_id", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "years", :force => true do |t|
    t.string   "name"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "years", ["name", "product_id"], :name => "index_years_on_name_and_product_id", :unique => true

end
