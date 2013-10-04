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
    super_klazz_id = student[:enrolled_super_klazz_ids]
    student = Student.create_temporary_student!(name, super_klazz_id)
    update_student(student.id)
  end

  def update_student(student_id)
    student_exam.student_id = student_id
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
    student_exam.string_of_answers = string_of_answers
    student_exam.set_exam_execution
    student_exam.status = StudentExam::VALID_STATUS    
    student_exam.save!
  end

  def update_student_answers(student_id, string_of_answers, exam_execution_id)
    student_exam.student_id = student_id
    student_exam.student_number = Student.find(student_id).ra
    student_exam.string_of_answers = string_of_answers
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
    student_exam.status = StudentExam::VALID_STATUS
    student_exam.save!
  end

  def update_repeated_student(student_id)
    student_exam.student_id = student_id
    student_exam.set_exam_execution
    student_exam.status = StudentExam::VALID_STATUS
    student_exam.save!(validates: false)
  end

  def update_and_create_new_repeated_student(student)
    name = student[:name]
    super_klazz_id = student[:enrolled_super_klazz_ids]
    student = Student.create_temporary_student!(name, super_klazz_id)
    update_student(student.id)
    student_exam.status = StudentExam::VALID_STATUS
    student_exam.save!(validates: false)
  end
end