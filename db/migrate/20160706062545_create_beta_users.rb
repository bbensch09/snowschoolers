class CreateBetaUsers < ActiveRecord::Migration
  def change
    create_table :beta_users do |t|
      t.string :email
      t.string :user_type

      t.timestamps
    end
  end
end
