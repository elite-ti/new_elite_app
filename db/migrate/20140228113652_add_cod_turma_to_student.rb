class AddCodTurmaToStudent < ActiveRecord::Migration
  def change
    add_column :students, :cod_turma, :string
  end
end
