class RegistrationsController < Devise::RegistrationsController

  def update_resource(resource, params)
    resource.update_without_password(sign_up_params)
  end

  private

    def sign_up_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone_no, :profile_picture, :date_of_birth, :user_type, :password, :password_confirmation)
    end

end
