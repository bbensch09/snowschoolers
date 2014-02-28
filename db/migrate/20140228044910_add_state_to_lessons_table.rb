class AddStateToLessonsTable < ActiveRecord::Migration
  def change
    add_column :lessons, :state, :string
  end
end
