class AddDurationAndStartTimeToLessonsTable < ActiveRecord::Migration
  def change
    add_column :lessons, :duration, :integer
    add_column :lessons, :start_time, :string
  end
end
