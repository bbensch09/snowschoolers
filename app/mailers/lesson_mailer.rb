class LessonMailer < ActionMailer::Base
  default from: 'brian@skischool.co'

  def new_user_signed_up(user)
    @user = user
    mail(to: 'brian@skischool.co', subject: "A new user has signed up for Ski School")
  end

  def send_lesson_request_to_instructors(lesson, excluded_instructor=nil)
    @lesson = lesson
    @available_instructors = (lesson.available_instructors - [excluded_instructor]).map(&:email)
    mail(bcc: @available_instructors, subject: 'New Ski SChool Co lesson request')
  end

  def send_lesson_confirmation(lesson)
    @lesson = lesson
    mail(to: @lesson.requester.email, subject: 'Your Ski SChool Co lesson has been confirmed')
  end

  def send_lesson_update_notice_to_instructor(original_lesson, updated_lesson, changed_attributes)
    @original_lesson = original_lesson
    @updated_lesson = updated_lesson
    @changed_attributes = changed_attributes
    mail(to: @updated_lesson.instructor.email, subject: 'One of your Ski SChool Co lesson has been updated')
  end

  def send_cancellation_email_to_instructor(lesson)
    @lesson = lesson
    mail(to: @lesson.instructor.email, subject: 'One of your Ski SChool Co lessons has been canceled')
  end

  def inform_requester_of_instructor_cancellation(lesson, available_instructors)
    @lesson = lesson
    @available_instructors = available_instructors
    mail(to: @lesson.requester.email, subject: 'Changes to your upcoming Ski SChool Co lesson')
  end

  def send_payment_email_to_requester(lesson)
    @lesson = lesson
    mail(to: @lesson.requester.email, subject: 'Please complete your Ski SChool Co lesson payment')
  end
end
