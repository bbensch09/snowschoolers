class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :create_lesson_from_session
  before_filter :authenticate_user!

  private

  def create_lesson_from_session
    return unless current_user && session[:lesson_time]
    params[:lesson_time] = session.delete(:lesson_time)
    create_lesson(auto: true)
  end

  def create_lesson(opts={})
    lesson = Lesson.new
    lesson.lesson_time = LessonTime.find_or_create_by(lesson_time_params)
    lesson.student = current_user

    notice = if lesson.save
      "Your <a href='#{lesson_path(lesson)}'>lesson</a> request is being processed.".html_safe
    else
      lesson.errors.full_messages.first
    end

    opts[:auto] ? flash.now[:notice] = notice : flash[:notice] = notice

    return lesson
  end

  def lesson_time_params
    params.require(:lesson_time).permit(:date, :slot)
  end
end
