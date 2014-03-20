class UpdateStudentExam
  attr_reader :params, :student_exam

  def initialize(params, student_exam)
    @params = params
    @student_exam = student_exam
  end

  def update
    ActiveRecord::Base.transaction do 
      if student_exam.student_not_found?
        if !params[:student].nil?
          update_and_create_new_student(params[:student])
        elsif !params[:student_id].nil?
          update_student(params[:student_id])
        end
      elsif student_exam.exam_not_found?
        if !params[:student].nil?
          update_and_update_student(params[:student])
        elsif !params[:exam_execution_id].nil?
          update_exam(params[:exam_execution_id])
        end
      elsif student_exam.invalid_answers?
        update_answers(params[:exam_answers_attributes])
      elsif student_exam.error?
        if !params[:student].nil? && !params[:string_of_answers].nil? 
          update_and_create_new_student_answers(params[:student],params[:string_of_answers])
        elsif !params[:student_id].nil? && !params[:string_of_answers].nil?
          update_student_answers(params[:student_id],params[:string_of_answers],params[:exam_execution_id])
        end
      elsif student_exam.repeated_student?
        if !params[:student].nil?
          update_and_create_new_repeated_student(params[:student])
        elsif !params[:student_id].nil?
          update_repeated_student(params[:student_id])
        end
      end
    end
  end

private

  def update_and_create_new_student(student)
    name = student[:name]
    ra = student[:ra]
    if @student_exam.is_bolsao
      super_klazz_id = student[:applied_super_klazz_ids]
      student = Student.new(name: name)
      student.applied_super_klazz_ids = [super_klazz_id]
      student.save
      if ra.present?
        student.number = student.calculate_temporary_number(super_klazz_id, 1)
      else
        student.number = ra
      end
      student.save
    else
      super_klazz_id = student[:enrolled_super_klazz_ids]
      if ra.present?
        student = Student.create!(name: name, ra: ra)
        student.enrolled_super_klazz_ids = [super_klazz_id]
        student.save!
        student.enrollments.map(&:save!)
      else
        student = Student.create_temporary_student!(name, super_klazz_id)
      end
    end
    update_student(student.id)
  end

  def update_student(student_id)
    student_exam.student_id = student_id
    if student_exam.card_processing.exam_execution.present?
      student = student_exam.student
      student.enrolled_super_klazz_ids = student.enrolled_super_klazz_ids + [student_exam.card_processing.exam_execution.super_klazz_id]
      student.save
    end
    student_exam.set_exam_execution
    student_exam.save!
  end

  def update_and_update_student(student)
    student_exam.student.update_attributes!(student)
    student_exam.reload
    student_exam.set_exam_execution
    student_exam.save!
  end

  def update_and_create_new_student_answers(student, string_of_answers)
    name = student[:name]
    super_klazz_id = student[:enrolled_super_klazz_ids]
    student = Student.create_temporary_student!(name, super_klazz_id)
    update_student(student.id)
    student_exam.exam_answers.destroy_all
    student_exam.string_of_answers = string_of_answers.upcase
    student_exam.set_exam_execution
    student_exam.status = StudentExam::VALID_STATUS    
    student_exam.save!
  end

  def update_student_answers(student_id, string_of_answers, exam_execution_id)
    student_exam.student_id = student_id
    student_exam.student_number = Student.find(student_id).ra
    student_exam.exam_answers.destroy_all
    student_exam.string_of_answers = string_of_answers.upcase
    student_exam.exam_execution_id = exam_execution_id
    student_exam.set_exam_answers
    student_exam.status = StudentExam::VALID_STATUS
    student_exam.save!
  end

  def update_exam(exam_execution_id)
    student_exam.exam_execution_id = exam_execution_id
    student_exam.set_exam_answers
    student_exam.save!
  end

  def update_answers(exam_answers_attributes)
    student_exam.exam_answers_attributes = exam_answers_attributes
    # student_exam.set_grades
    student_exam.status = StudentExam::VALID_STATUS
    student_exam.save!
  end

  def update_repeated_student(student_id)
    student_exam.student_id = student_id
    student_exam.exam_answers.destroy_all
    student_exam.set_exam_execution
    student_exam.save!
    student_exam.status = StudentExam::VALID_STATUS
    student_exam.update_column(:status, student_exam.status)
  end

  def update_and_create_new_repeated_student(student)
    name = student[:name]
    super_klazz_id = student[:enrolled_super_klazz_ids]
    student = Student.create_temporary_student!(name, super_klazz_id)
    update_student(student.id)
    student_exam.save!
    student_exam.status = StudentExam::VALID_STATUS
    student_exam.update_column(:status, student_exam.status)
  end
end