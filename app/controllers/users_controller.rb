class UsersController < ApplicationController

  USERS_PER_PAGE = 10

  def index
    @users = User.page(params[:page]).per(USERS_PER_PAGE)
  end
  def show
    @user = User.find_by_id(params[:id])
    redirect_to users_path, alert: "User not found !" unless @user
  end
end
