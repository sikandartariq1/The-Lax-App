class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_entity
    current_user || current_old_salt
  end

end
