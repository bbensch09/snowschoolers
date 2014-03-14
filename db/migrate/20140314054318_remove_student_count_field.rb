class RemoveStudentCountField < ActiveRecord::Migration
  def change
    remove_column :lessons, :student_count, :integer
  end
end
