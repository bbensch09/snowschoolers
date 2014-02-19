class LessonsController < ApplicationController

  def show
    @lesson = Lesson.find(params[:id])
    @lesson_time = @lesson.lesson_time
    check_user_permissions
  end

  def set_instructor
    set_lesson_instructor
    LessonMailer.send_lesson_confirmation(@lesson).deliver if Rails.env.production?
    redirect_to @lesson
  end

  private

  def check_user_permissions
    unless current_user && (current_user == @lesson.student || current_user.instructor?)
      flash[:alert] = "You do not have access to this page."
      redirect_to root_path
    end 
  end

  def set_lesson_instructor
    @lesson = Lesson.find(params[:id])
    @lesson.instructor = current_user
    @lesson.save
  end
end
