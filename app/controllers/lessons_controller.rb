class LessonsController < ApplicationController

  def show
    @lesson = Lesson.find(params[:id])
    @lesson_time = @lesson.lesson_time
  end

  def set_instructor
    set_lesson_instructor
    redirect_to @lesson
  end

  private


  def set_lesson_instructor
    @lesson = Lesson.find(params[:id])
    @lesson.instructor = current_user
    @lesson.save
  end
end
