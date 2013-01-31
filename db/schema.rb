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

ActiveRecord::Schema.define(:version => 20130130200346) do

  create_table "absence_reasons", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "absence_reasons", ["name"], :name => "index_absence_reasons_on_name", :unique => true

  create_table "addresses", :force => true do |t|
    t.string   "complement"
    t.string   "number"
    t.string   "street"
    t.string   "suburb"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "cep"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "admins", :force => true do |t|
    t.integer  "employee_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "admins", ["employee_id"], :name => "index_admins_on_employee_id", :unique => true

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
    t.string   "number"
    t.string   "bolsao_id"
    t.datetime "subscription_datetime"
    t.datetime "exam_datetime"
    t.integer  "exam_campus_id"
    t.integer  "student_id",            :null => false
    t.integer  "year_id",               :null => false
    t.integer  "intended_campus_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "applicants", ["number", "bolsao_id"], :name => "index_applicants_on_number_and_bolsao_id", :unique => true
  add_index "applicants", ["year_id", "student_id"], :name => "index_applicants_on_year_id_and_student_id", :unique => true

  create_table "campus_head_teacher_campuses", :force => true do |t|
    t.integer  "campus_head_teacher_id", :null => false
    t.integer  "campus_id",              :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "campus_head_teacher_campuses", ["campus_head_teacher_id", "campus_id"], :name => "index_chtc_on_chtid_and_cid", :unique => true

  create_table "campus_head_teacher_products", :force => true do |t|
    t.integer  "campus_head_teacher_id", :null => false
    t.integer  "product_id",             :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "campus_head_teacher_products", ["campus_head_teacher_id", "product_id"], :name => "index_chtp_on_chtid_and_pid", :unique => true

  create_table "campus_head_teachers", :force => true do |t|
    t.integer  "employee_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "campus_head_teachers", ["employee_id"], :name => "index_campus_head_teachers_on_employee_id", :unique => true

  create_table "campus_preferences", :force => true do |t|
    t.integer  "teacher_id", :null => false
    t.integer  "campus_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "campus_preferences", ["campus_id", "teacher_id"], :name => "index_cp_on_cid_and_tid", :unique => true

  create_table "campus_principals", :force => true do |t|
    t.integer  "employee_id", :null => false
    t.integer  "campus_id",   :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "campus_principals", ["employee_id"], :name => "index_campus_principals_on_employee_id", :unique => true

  create_table "campuses", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "campuses", ["name"], :name => "index_campuses_on_name", :unique => true

  create_table "card_types", :force => true do |t|
    t.string   "name",                :null => false
    t.string   "parameters",          :null => false
    t.string   "card",                :null => false
    t.string   "student_coordinates", :null => false
    t.string   "command",             :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "card_types", ["name"], :name => "index_card_types_on_name", :unique => true

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

  create_table "enrollments", :force => true do |t|
    t.integer  "student_id", :null => false
    t.integer  "klazz_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "enrollments", ["student_id", "klazz_id"], :name => "index_enrollments_on_student_id_and_klazz_id", :unique => true

  create_table "exam_answers", :force => true do |t|
    t.integer  "student_exam_id",  :null => false
    t.integer  "exam_question_id", :null => false
    t.string   "answer",           :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "exam_answers", ["student_exam_id", "exam_question_id"], :name => "index_exam_answers_on_student_exam_id_and_exam_question_id", :unique => true

  create_table "exam_cycles", :force => true do |t|
    t.string   "name"
    t.boolean  "is_bolsao",  :default => false, :null => false
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "year_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "exam_cycles", ["name", "year_id"], :name => "index_exam_cycles_on_name_and_year_id", :unique => true

  create_table "exam_questions", :force => true do |t|
    t.integer  "question_id", :null => false
    t.integer  "exam_id",     :null => false
    t.integer  "number",      :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "exam_questions", ["question_id", "exam_id"], :name => "index_exam_questions_on_question_id_and_exam_id", :unique => true

  create_table "exam_subjects", :force => true do |t|
    t.integer  "subject_id"
    t.integer  "exam_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "exam_subjects", ["subject_id", "exam_id"], :name => "index_exam_subjects_on_subject_id_and_exam_id", :unique => true

  create_table "exams", :force => true do |t|
    t.datetime "date"
    t.integer  "exam_cycle_id"
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "exams", ["exam_cycle_id", "name"], :name => "index_exams_on_exam_cycle_id_and_name", :unique => true

  create_table "klazz_types", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "klazz_types", ["name"], :name => "index_klazz_types_on_name", :unique => true

  create_table "klazzes", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "year_id",    :null => false
    t.integer  "campus_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "klazzes", ["name", "year_id"], :name => "index_klazzes_on_name_and_year_id", :unique => true

  create_table "majors", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "majors", ["name"], :name => "index_majors_on_name", :unique => true

  create_table "names", :force => true do |t|
    t.text     "itens"
    t.integer  "subject_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "poll_answers", :force => true do |t|
    t.integer  "poll_question_id", :null => false
    t.integer  "grade",            :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "poll_answers", ["poll_question_id"], :name => "index_poll_answers_on_poll_question_id"

  create_table "poll_pdfs", :force => true do |t|
    t.integer  "klazz_id",   :null => false
    t.integer  "poll_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "poll_pdfs", ["klazz_id", "poll_id"], :name => "index_poll_pdfs_on_klazz_id_and_poll_id", :unique => true

  create_table "poll_question_categories", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "poll_question_categories", ["name"], :name => "index_poll_question_categories_on_name", :unique => true

  create_table "poll_question_types", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "poll_question_types", ["name"], :name => "index_poll_question_types_on_name", :unique => true

  create_table "poll_questions", :force => true do |t|
    t.integer  "poll_pdf_id",               :null => false
    t.integer  "poll_question_type_id",     :null => false
    t.integer  "poll_question_category_id", :null => false
    t.integer  "teacher_id"
    t.integer  "number",                    :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "poll_questions", ["poll_pdf_id", "number"], :name => "index_poll_questions_on_ppid_and_number", :unique => true

  create_table "polls", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "polls", ["name"], :name => "index_polls_on_name", :unique => true

  create_table "product_group_preferences", :force => true do |t|
    t.integer  "teacher_id",       :null => false
    t.integer  "product_group_id", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "preference",       :null => false
  end

  add_index "product_group_preferences", ["product_group_id", "teacher_id"], :name => "index_pgp_on_pgid_and_tid", :unique => true

  create_table "product_groups", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "product_groups", ["name"], :name => "index_product_groups_on_name", :unique => true

  create_table "product_head_teacher_products", :force => true do |t|
    t.integer  "product_head_teacher_id", :null => false
    t.integer  "product_id",              :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "product_head_teacher_products", ["product_head_teacher_id", "product_id"], :name => "index_phtp_on_phtid_and_pid", :unique => true

  create_table "product_head_teachers", :force => true do |t|
    t.integer  "employee_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "product_head_teachers", ["employee_id"], :name => "index_product_head_teachers_on_employee_id", :unique => true

  create_table "product_principals", :force => true do |t|
    t.integer  "employee_id", :null => false
    t.integer  "product_id",  :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "product_principals", ["employee_id"], :name => "index_product_principals_on_employee_id", :unique => true

  create_table "product_types", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "product_types", ["name"], :name => "index_product_types_on_name", :unique => true

  create_table "products", :force => true do |t|
    t.string   "name",             :null => false
    t.integer  "product_type_id",  :null => false
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
    t.integer  "teacher_id",     :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "questions", ["name"], :name => "index_questions_on_name", :unique => true

  create_table "school_roles", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "school_roles", ["name"], :name => "index_school_roles_on_name", :unique => true

  create_table "student_exams", :force => true do |t|
    t.integer  "exam_id",      :null => false
    t.string   "card",         :null => false
    t.integer  "student_id"
    t.string   "status"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "card_type_id", :null => false
  end

  create_table "students", :force => true do |t|
    t.string   "name",               :null => false
    t.string   "ra"
    t.string   "email"
    t.string   "password_digest"
    t.string   "cpf"
    t.string   "own_cpf"
    t.string   "rg"
    t.string   "rg_expeditor"
    t.string   "gender"
    t.string   "date_of_birth"
    t.string   "number_of_children"
    t.string   "mother_name"
    t.string   "father_name"
    t.integer  "address_id"
    t.string   "telephone"
    t.string   "cellphone"
    t.string   "previous_school"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "students", ["email"], :name => "index_students_on_email", :unique => true
  add_index "students", ["ra"], :name => "index_students_on_ra", :unique => true

  create_table "subject_head_teacher_products", :force => true do |t|
    t.integer  "subject_head_teacher_id", :null => false
    t.integer  "product_id",              :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "subject_head_teacher_products", ["subject_head_teacher_id", "product_id"], :name => "index_shtp_on_shtid_and_pid", :unique => true

  create_table "subject_head_teacher_subjects", :force => true do |t|
    t.integer  "subject_head_teacher_id", :null => false
    t.integer  "subject_id",              :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "subject_head_teacher_subjects", ["subject_head_teacher_id", "subject_id"], :name => "index_shts_on_shtid_and_sid", :unique => true

  create_table "subject_head_teachers", :force => true do |t|
    t.integer  "employee_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "subject_head_teachers", ["employee_id"], :name => "index_subject_head_teachers_on_employee_id", :unique => true

  create_table "subject_thread_topics", :force => true do |t|
    t.integer  "subject_thread_id", :null => false
    t.integer  "topic_id",          :null => false
    t.integer  "weight",            :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "subject_thread_topics", ["subject_thread_id", "topic_id"], :name => "index_subject_thread_topics_on_subject_thread_id_and_topic_id", :unique => true

  create_table "subject_threads", :force => true do |t|
    t.integer  "subject_id", :null => false
    t.integer  "year_id",    :null => false
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "subject_threads", ["subject_id", "year_id", "name"], :name => "index_subject_threads_on_subject_id_and_year_id_and_name", :unique => true

  create_table "subjects", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "short_name", :null => false
    t.string   "code",       :null => false
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
    t.integer  "time_table_id",     :null => false
    t.integer  "teacher_id"
    t.integer  "subject_id"
    t.integer  "klazz_type_id"
    t.integer  "absence_reason_id"
    t.boolean  "excused"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "teacher_absences", ["time_table_id"], :name => "index_teacher_absences_on_time_table_id", :unique => true

  create_table "teachers", :force => true do |t|
    t.integer  "employee_id",            :null => false
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
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "teachers", ["employee_id"], :name => "index_teachers_on_employee_id", :unique => true

  create_table "teaching_assignments", :force => true do |t|
    t.integer  "klazz_id",   :null => false
    t.integer  "teacher_id"
    t.integer  "subject_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "time_tables", :force => true do |t|
    t.integer  "teaching_assignment_id", :null => false
    t.integer  "klazz_type_id"
    t.integer  "position",               :null => false
    t.date     "date",                   :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "linked_time_table"
  end

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.text     "itens"
    t.integer  "subject_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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
    t.string   "name",        :null => false
    t.string   "year_number", :null => false
    t.integer  "product_id",  :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "years", ["name", "product_id"], :name => "index_years_on_name_and_product_id", :unique => true
  add_index "years", ["year_number", "product_id"], :name => "index_years_on_year_number_and_product_id", :unique => true

end
