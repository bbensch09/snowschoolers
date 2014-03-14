class CreateStudentsTable < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.references :lesson
      t.string :name
      t.string :age_range
      t.string :gender
      t.string :relationship_to_requester
    end
  end
end
