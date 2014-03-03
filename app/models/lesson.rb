class Lesson < ActiveRecord::Base
  belongs_to :requester, class_name: 'User', foreign_key: 'requester_id'
  belongs_to :instructor, class_name: 'User', foreign_key: 'instructor_id'
  belongs_to :lesson_time

  validates :activity, :location, :lesson_time, presence: true
  validates :student_count, :objectives, :duration, :start_time, presence: true, on: :update
  validates :gear, inclusion: { in: [true, false] }, on: :update
  validate :instructors_must_be_available, on: :create
  validate :requester_must_not_be_instructor, on: :create

  after_create :send_lesson_request_to_instructors

  def date
    lesson_time.date
  end

  def slot
    lesson_time.slot
  end

  def active?
    state != 'canceled'
  end

  def pending_instructor?
    state == 'pending instructor'
  end

  def pending_requester?
    state == 'pending requester'
  end

  def available_instructors
    User.instructors - Lesson.booked_instructors(lesson_time)
  end

  def self.find_lesson_times_by_requester(user)
    self.where('requester_id = ?', user.id).map { |lesson| lesson.lesson_time }
  end

  def self.booked_instructors(lesson_time)
    booked_lessons = self.where('lesson_time_id = ? AND instructor_id is not null', lesson_time.id)
    booked_lessons.map { |lesson| User.find(lesson.instructor_id) }
  end

  private

  def instructors_must_be_available
    errors.add(:instructor, "not available") unless available_instructors.any?
  end

  def requester_must_not_be_instructor
    errors.add(:instructor, "cannot request a lesson") if self.requester.instructor?
  end

  def send_lesson_request_to_instructors
    LessonMailer.send_lesson_request_to_instructors(self).deliver
  end
end
