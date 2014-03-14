class Student < ActiveRecord::Base
  belongs_to :lesson

  validates :name, :age_range, :gender, :relationship_to_requester, presence: true
end
