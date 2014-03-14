class AddTermsFieldToLessonsTable < ActiveRecord::Migration
  def change
    add_column :lessons, :terms_accepted, :boolean
  end
end
