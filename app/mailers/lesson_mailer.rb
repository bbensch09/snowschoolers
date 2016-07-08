class LessonMailer < ActionMailer::Base
  default from: 'brian@snowschoolers.com'

  def new_user_signed_up(user)
    @user = user
    mail(to: 'brian@snowschoolers.com', subject: "A new user has signed up for Ski School")
  end

  def send_lesson_request_to_instructors(lesson, excluded_instructor=nil)
    @lesson = lesson
    @available_instructors = (lesson.available_instructors - [excluded_instructor]).map(&:email)
    mail(to: 'notify@snowschoolers.com', bcc: @available_instructors, subject: 'New Snow Schoolers lesson request')
  end

  def send_lesson_confirmation(lesson)
    @lesson = lesson
    mail(to: @lesson.requester.email, cc:'notify@snowschoolers.com', subject: 'Your Snow Schoolers lesson has been confirmed')
  end

  def send_lesson_update_notice_to_instructor(original_lesson, updated_lesson, changed_attributes)
    @original_lesson = original_lesson
    @updated_lesson = updated_lesson
    @changed_attributes = changed_attributes
    mail(to: @updated_lesson.instructor.email, cc:'notify@snowschoolers.com', subject: 'One of your Snow Schoolers lesson has been updated')
  end

  def send_cancellation_email_to_instructor(lesson)
    @lesson = lesson
    mail(to: @lesson.instructor.email, cc:'notify@snowschoolers.com', subject: 'One of your Snow Schoolers lessons has been canceled')
  end

  def inform_requester_of_instructor_cancellation(lesson, available_instructors)
    @lesson = lesson
    @available_instructors = available_instructors
    mail(to: @lesson.requester.email, cc:'notify@snowschoolers.com', subject: 'Your Snow Schoolers lesson has been canceled')
  end

  def send_payment_email_to_requester(lesson)
    @lesson = lesson
    mail(to: @lesson.requester.email, cc:'notify@snowschoolers.com', subject: 'Please complete your Snow Schoolers lesson payment')
  end
end
