class Lesson < ActiveRecord::Base
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'
  belongs_to :instructor, class_name: 'User', foreign_key: 'instructor_id'
  belongs_to :lesson_time
end
