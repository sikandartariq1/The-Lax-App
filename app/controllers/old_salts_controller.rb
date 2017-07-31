class OldSaltsController < ApplicationController
  def show
    @old_salt = OldSalt.find_by_id(params[:id])
    redirect_to old_salts_path, alert: "User not found !" unless @old_salt
  end
end
