class RegistrationsController < Devise::RegistrationsController

  def update_resource(resource, params)
    resource.update_without_password(account_update_params)
  end

  private
  def sign_up_params
    params.require(:user).permit(permit_params)
  end
  def account_update_params
    params.require(:user).permit(permit_params, :current_password, :date_of_birth, :user_type)
  end
  def permit_params
    [:first_name, :last_name, :email, :password, :password_confirmation, :phone_no, :profile_picture]
  end
end
