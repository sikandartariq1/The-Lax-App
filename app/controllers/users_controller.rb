class UsersController < ApplicationController
  before_action :authenticate_old_salt!, only: [:index]
  USERS_PER_PAGE = 10

  def index
    @users = current_old_salt.users.page(params[:page]).per(USERS_PER_PAGE)
  end
  def show
    @user = User.find_by_id(params[:id])
    redirect_to users_path, alert: "User not found !" unless @user
  end
end
