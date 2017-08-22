class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  User.social_sites.each do |name|
    define_method name do
      social_site
    end
  end

  private

    def social_site
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user.errors.messages.present?
        redirect_to user_session_path, alert: @user.errors.full_messages.first
      else
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: request.env["omniauth.auth"].provider
        sign_in_and_redirect @user, event: :authentication
      end
    end

end
