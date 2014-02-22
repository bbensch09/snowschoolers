class LessonsController < ApplicationController
  respond_to :html

  skip_before_filter :authenticate_user!, only: [:new, :create]
  before_filter :save_lesson_params_and_redirect, only: :create
  before_filter :create_lesson_from_session

  def new
    @lesson = Lesson.new
    @lesson_time = @lesson.lesson_time
  end

  def create
    create_lesson
  end

  def complete
    @lesson = Lesson.find(params[:id])
    @lesson_time = @lesson.lesson_time
  end

  def edit
    @lesson = Lesson.find(params[:id])
    @lesson_time = @lesson.lesson_time
  end

  def update
    @lesson = Lesson.find(params[:id])
    @lesson.update(lesson_params)
    @lesson_time = @lesson.lesson_time
    @lesson_time.update(lesson_time_params)
    @lesson.errors.add(:lesson_time, "invalid") unless @lesson_time.valid?
    respond_with @lesson
  end

  def show
    @lesson = Lesson.find(params[:id])
    check_user_permissions
  end

  def set_instructor
    set_lesson_instructor
    LessonMailer.send_lesson_confirmation(@lesson).deliver if Rails.env.production?
    redirect_to @lesson
  end

  private

  def save_lesson_params_and_redirect
    unless current_user
      flash[:alert] = "You need to sign in or sign up before continuing."
      session[:lesson] = params[:lesson]
      redirect_to new_user_session_path and return
    end
  end

  def create_lesson_from_session
    return unless current_user && session[:lesson]
    params[:lesson] = session.delete(:lesson)
    create_lesson
  end

  def create_lesson
    @lesson = Lesson.new(lesson_params)
    @lesson.student = current_user
    @lesson_time = @lesson.lesson_time = LessonTime.find_or_create_by(lesson_time_params)
    @lesson.errors.add(:lesson_time, "invalid") unless @lesson_time.valid?
    @lesson.save ? (redirect_to complete_lesson_path(@lesson)) : (render :new)
  end

  def lesson_params
    params.require(:lesson).permit(:activity, :location, :student_count, :gear, :objectives)
  end

  def lesson_time_params
    params[:lesson].require(:lesson_time).permit(:date, :slot)
  end

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
