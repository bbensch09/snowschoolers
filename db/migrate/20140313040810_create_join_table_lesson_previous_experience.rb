class CreateJoinTableLessonPreviousExperience < ActiveRecord::Migration
  def change
    create_join_table :lessons, :previous_experiences do |t|
      # t.index [:lesson_id, :previous_experience_id]
      # t.index [:previous_experience_id, :lesson_id]
    end
  end
end
