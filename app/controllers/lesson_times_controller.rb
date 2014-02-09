class LessonTimesController < ApplicationController
  before_filter :save_lesson_params_and_redirect, only: :create

  def new
    @lesson_time = LessonTime.new
  end

  def create
    lesson = create_lesson
    flash[:notice] = "Your <a href='#{lesson_path(lesson)}'>lesson</a> request is being processed.".html_safe
    redirect_to root_path
  end

  private

  def save_lesson_params_and_redirect
    unless current_user
      flash[:alert] = "You need to sign in or sign up before continuing."
      session[:lesson_time] = params[:lesson_time]
      redirect_to new_user_session_path and return
    end
  end
end
