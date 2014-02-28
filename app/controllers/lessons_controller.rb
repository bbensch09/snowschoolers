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
    create_lesson_and_redirect
  end

  def complete
    @lesson = Lesson.find(params[:id])
    @lesson_time = @lesson.lesson_time
    @state = 'booked'
  end

  def edit
    @lesson = Lesson.find(params[:id])
    @lesson_time = @lesson.lesson_time
    @state = @lesson.instructor ? 'pending instructor' : 'booked'
  end

  def update
    update_lesson_and_redirect
  end

  def show
    @lesson = Lesson.find(params[:id])
    check_user_permissions
  end

  def destroy
    cancel_lesson_and_redirect
  end

  def set_instructor
    set_lesson_instructor_and_redirect
  end

  def remove_instructor
    remove_lesson_instructor_and_redirect
  end

  private

  def save_lesson_params_and_redirect
    unless current_user
      flash[:alert] = 'You need to sign in or sign up before continuing.'
      session[:lesson] = params[:lesson]
      redirect_to new_user_session_path and return
    end
  end

  def create_lesson_from_session
    return unless current_user && session[:lesson]
    params[:lesson] = session.delete(:lesson)
    create_lesson_and_redirect
  end

  def create_lesson_and_redirect
    @lesson = Lesson.new(lesson_params)
    @lesson.requester = current_user
    @lesson_time = @lesson.lesson_time = LessonTime.find_or_create_by(lesson_time_params)
    @lesson.errors.add(:lesson_time, 'invalid') unless @lesson_time.valid?
    @lesson.save ? (redirect_to complete_lesson_path(@lesson)) : (render :new)
  end

  def update_lesson_and_redirect
    @lesson = Lesson.find(params[:id])
    @original_lesson = @lesson.dup
    @lesson.update(lesson_params)
    @lesson_time = @lesson.lesson_time = LessonTime.find_or_create_by(lesson_time_params)
    
    if @lesson_time.valid?
      send_lesson_update_notice_to_instructor if @lesson.valid?
    else
      @lesson.errors.add(:lesson_time, 'invalid')
    end
    
    respond_with @lesson
  end

  def cancel_lesson_and_redirect
    @lesson = Lesson.find(params[:id])
    @lesson.update(state: 'canceled')
    send_cancellation_email_to_instructor
    flash[:notice] = 'Your lesson has been canceled.'
    redirect_to root_path
  end

  def check_user_permissions
    unless current_user && (current_user == @lesson.requester || current_user.instructor?)
      flash[:alert] = "You do not have access to this page."
      redirect_to root_path
    end 
  end

  def send_lesson_update_notice_to_instructor
    if @lesson.instructor.present?
      changed_attributes = get_changed_attributes
      return unless changed_attributes.any?
      LessonMailer.send_lesson_update_notice_to_instructor(@original_lesson, @lesson, changed_attributes).deliver
    end
  end

  def get_changed_attributes
    lesson_changes = @lesson.previous_changes
    lesson_time_changes = @lesson_time.attributes.diff(@original_lesson.lesson_time.attributes)
    changed_attributes = lesson_changes.merge(lesson_time_changes)
    changed_attributes.reject { |attribute, change| attribute == 'updated_at' || attribute == 'id' }
  end

  def send_cancellation_email_to_instructor
    if @lesson.instructor.present?
      LessonMailer.send_cancellation_email_to_instructor(@lesson).deliver
    end
  end

  def set_lesson_instructor_and_redirect
    @lesson = Lesson.find(params[:id])
    @lesson.instructor = current_user
    @lesson.update(state: 'confirmed')
    LessonMailer.send_lesson_confirmation(@lesson).deliver
    redirect_to @lesson
  end

  def remove_lesson_instructor_and_redirect
    @lesson = Lesson.find(params[:id])
    @lesson.instructor = nil
    @lesson.update(state: 'pending requester')
    redirect_to @lesson
  end

  def lesson_params
    params.require(:lesson).permit(:activity, :location, :state, :student_count, :gear, :objectives)
  end

  def lesson_time_params
    params[:lesson].require(:lesson_time).permit(:date, :slot)
  end
end
