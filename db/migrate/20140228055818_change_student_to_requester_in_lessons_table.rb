class ChangeStudentToRequesterInLessonsTable < ActiveRecord::Migration
  def change
    rename_column :lessons, :student_id, :requester_id
  end
end
