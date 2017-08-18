class OldSaltsController < ApplicationController
  before_action :authenticate_old_salt!, only: [:edit, :update]

  def index
    old_salts_per_page = 10
    @old_salts = OldSalt.page(params[:page]).per(old_salts_per_page)
  end
  def show
    @old_salt = OldSalt.find_by_id(params[:id])
    redirect_to old_salts_path, alert: "User not found !" unless @old_salt
  end
  def edit
    @old_salt = current_old_salt
  end
  def update
    @old_salt = current_old_salt
    if @old_salt.update(old_salt_params)
      redirect_to @old_salt, notice: "changings have been saved."
    else
      render 'edit'
    end
  end
  private
  def old_salt_params
    params.require(:old_salt).permit(:first_name, :last_name, :phone_no, :profile_picture, :date_of_birth)
  end
end
