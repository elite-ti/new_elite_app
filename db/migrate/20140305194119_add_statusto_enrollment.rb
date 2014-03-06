class AddStatustoEnrollment < ActiveRecord::Migration
  def up
    add_column :enrollments, :status, :string
    Enrollment.includes(:super_klazz => [:campus, product_year: :year]).each do |enr|
      if enr.super_klazz.product_year.year.number == 2014
        enr.status = "Matriculado"
      else
        enr.status = "Aprovado"
      end
      enr.save
    end
  end

  def down
    remove_column :enrollments, :status
  end
end
