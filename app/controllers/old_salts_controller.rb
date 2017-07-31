class OldSaltsController < ApplicationController
  def index
    old_salts_per_page = 10
    @old_salts = OldSalt.page(params[:page]).per(old_salts_per_page)
  end
  def show
    @old_salt = OldSalt.find_by_id(params[:id])
    redirect_to old_salts_path, alert: "User not found !" unless @old_salt
  end
end
