class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :lessons
  has_many :lesson_times, through: :lessons
  after_create :send_admin_notification

  def send_admin_notification
      @user = User.last
      LessonMailer.new_user_signed_up(@user).deliver
      puts "an admin notification has been sent."
  end

  def self.instructors
    self.where('instructor = true')
  end

  def lesson_times
    Lesson.find_lesson_times_by_requester(self)
  end

  # Facebook OAuth

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.instructor = false
      user.image = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  # Devise overrides

  def password_required?
    super || provider.blank?
  end

  def update_with_password(params, *options)
    current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = if valid_password?(current_password)
      update_columns(params, *options)
    else
      self.assign_attributes(params, *options)
      self.valid?
      self.errors.messages.delete(:password) unless params[:password]
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      false
    end

    clean_up_passwords
    result
  end
end
