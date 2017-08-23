class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  User.social_sites.each do |name|
    define_method name do
      social_site
    end
  end

  private

    def social_site
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user
        sign_in @user
        redirect_to current_user, notice: "Signed in successfully!" if user_signed_in?
      else
        redirect_to user_session_path, alert: "Email already registered."
      end
    end

end
