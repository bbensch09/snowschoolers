class LessonTime < ActiveRecord::Base
  has_many :lessons
  has_many :users, through: :lessons

  validates :date, :slot, presence: true
end
