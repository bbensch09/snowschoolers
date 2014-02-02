class AddLessonTimesTable < ActiveRecord::Migration
  def change
    create_table :lesson_times do |t|
      t.date :lesson_date
      t.string :slot
    end
  end
end
