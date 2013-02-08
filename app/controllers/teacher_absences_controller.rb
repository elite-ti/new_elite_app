class TeacherAbsencesController < ApplicationController
  load_and_authorize_resource

  def index
  	@teacher_absences = @teacher_absences.includes(
      period: {teaching_assignment: [:teacher, :subject, {klazz: :campus}]})
  end

  def edit
  end

  def update
  	respond_to do |format|
  		format.js do
        @teacher_absence.update_attributes!(params[:teacher_absence])
      end
      format.html do
        if @teacher_absence.update_attributes(params[:teacher_absence])
          redirect_to teacher_absences_url
        else
          render 'edit'
        end
      end
  	end
  end
end
