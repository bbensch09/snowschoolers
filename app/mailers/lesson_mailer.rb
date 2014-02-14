class LessonMailer < ActionMailer::Base
  default from: 'snowschoolers@gmail.com'

  def send_lesson_request_to_instructors(lesson)
    @lesson = lesson
    @available_instructors = lesson.available_instructors.map(&:email)
    mail(bcc: @available_instructors, subject: 'New Snow Schoolers Lesson Request')
  end
end