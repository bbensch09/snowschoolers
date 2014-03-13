class AddExperienceLevelToLessonsTable < ActiveRecord::Migration
  def change
    add_column :lessons, :experience_level, :integer
  end
end
