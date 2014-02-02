class LessonTimesController < ApplicationController
  def new
    @lesson_time = LessonTime.new
  end

  def create
    if current_user
      lesson = create_lesson(params)
      send_email_to_instructors(lesson)
      flash[:notice] = "Your lesson request is being processed."
    else
      flash[:alert] = "Please log in to request a lesson."
    end
    redirect_to root_path
  end

  private

    def create_lesson(params)
      lesson = Lesson.new
      lesson.lesson_time = LessonTime.find_or_create_by_lesson_date_and_slot(params)
      lesson.student = current_user
      lesson.save
    end

    def send_email_to_instructors(lesson)
      # send emails w/ link to lesson
    end
end
