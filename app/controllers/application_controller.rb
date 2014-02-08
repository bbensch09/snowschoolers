class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(user)
    if params[:user][:date] && params[:user][:slot]
      params[:lesson_time] = { date: params[:user][:date], slot: params[:user][:slot] }
      lesson = create_lesson
      flash[:notice] = "Your <a href='#{lesson_path(lesson)}'>lesson</a> request is being processed.".html_safe
    end
    stored_location_for(user) || signed_in_root_path(user)
  end

  private

  def create_lesson
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
