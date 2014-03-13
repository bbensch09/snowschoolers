class CreateLessonTimesTable < ActiveRecord::Migration
  def change
    create_table :lesson_times do |t|
      t.date :date
      t.string :slot
    end
  end
end
