class LessonTime < ActiveRecord::Base
  has_many :lessons
  has_many :users, through: :lessons

  validates :date, :slot, presence: true

  def self.find_morning_slot(date)
    LessonTime.find_by_date_and_slot(date, 'Morning')
  end

  def self.find_afternoon_slot(date)
    LessonTime.find_by_date_and_slot(date, 'Afternoon')
  end
end
