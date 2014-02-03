class LessonTimesController < ApplicationController
  def new
    @lesson_time = LessonTime.new
  end

  def create
    if current_user
      lesson = create_lesson(params)
      flash[:notice] = "Your <a href='#{lesson_path(lesson)}'>lesson</a> request is being processed.".html_safe
    else
      flash[:alert] = "Please log in to request a lesson."
    end
    redirect_to root_path
  end

  private

    def create_lesson(params)
      lesson = Lesson.new
      lesson.lesson_time = LessonTime.find_or_create_by(lesson_time_params)
      lesson.student = current_user
      lesson.save
      return lesson
    end

    def lesson_time_params
      params.require(:lesson_time).permit(:date, :slot)
    end
end
