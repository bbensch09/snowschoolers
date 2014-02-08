class LessonTimesController < ApplicationController
  def new
    @lesson_time = LessonTime.new
  end

  def create
    if current_user
      lesson = create_lesson
      flash[:notice] = "Your <a href='#{lesson_path(lesson)}'>lesson</a> request is being processed.".html_safe
    else
      flash[:alert] = "Please log in to request a lesson."
    end
    redirect_to root_path
  end
end
