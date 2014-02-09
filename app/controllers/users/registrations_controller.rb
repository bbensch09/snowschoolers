class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :instructor, :password, 
                                                                   :password_confirmation, :current_password) }
  end

  def update_resource(resource, params)
    if resource.provider == "facebook"
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end
end 