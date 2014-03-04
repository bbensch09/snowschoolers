class AddStartEndAndTotalTimeToLessonsTable < ActiveRecord::Migration
  def change
    add_column :lessons, :actual_start_time, :string
    add_column :lessons, :actual_end_time, :string
    add_column :lessons, :actual_duration, :float
  end
end
