class CreateLessonsTable < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :student_id
      t.integer :instructor_id
      t.references :lesson_time
      t.timestamps
    end
  end
end
