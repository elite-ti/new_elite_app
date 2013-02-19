class UpdateStudentExam
  attr_reader :params, :student_exam

  def initialize(params, student_exam)
    @params = params
    @student_exam = student_exam
  end

  def update
    if student_exam.student_not_found?
      update_student(params[:student_id])
    elsif student_exam.exam_not_found?
      update_exam(params[:exam_id])
    elsif student_exam.invalid_answers?
      update_answers(params[:exam_answers_attributes])
    end
    student_exam.save
  end

private

  def update_student(student_id)
    student_exam.student_id = student_id
    if student_exam.student.nil?
      errors.add(:student_id, 'student not found')
    else
      student_exam.set_exam
    end
  end

  def update_exam(exam_id)
    student_exam.exam_id = exam_id
    if student_exam.exam.nil?
      errors.add(:exam, 'exam not found')
    else
      student_exam.set_exam_answers
    end
  end

  def update_answers(exam_answers_attributes)
    student_exam.exam_answers_attributes = exam_answers_attributes
    student_exam.status = StudentExam::VALID_STATUS
  end
end