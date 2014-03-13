class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :instructor
      t.timestamps
    end
  end
end
