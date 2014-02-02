class LessonsController < ApplicationController
  def show
    @lesson = Lesson.find(params[:id])
  end

  def set_instructor
    lesson = Lesson.find(params[:id])
    lesson.instructor = current_user
    lesson.save
    redirect_to lesson
  end
end
