class CreatePreviousExperiencesTable < ActiveRecord::Migration
  def change
    create_table :previous_experiences do |t|
      t.string :name
      t.timestamps
    end
  end
end
