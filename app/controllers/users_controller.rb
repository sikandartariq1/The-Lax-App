class UsersController < ApplicationController
  before_action :authenticate_old_salt!, only: [:index]
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]

  USERS_PER_PAGE = 10

  def index
    @users = current_old_salt.users.page(params[:page]).per(USERS_PER_PAGE)
  end

  def show
    @user = User.find_by_id(params[:id])
    redirect_to users_path, alert: "User not found !" unless @user
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to current_user, notice: "Changings have been saved."
    else
      render :edit
    end
  end

  private

    def user_params
      if params[:user][:password].present?
        params.require(:user).permit(:email, :password, :password_confirmation)
      else
        params.require(:user).permit(:email)
      end
    end

    def set_user
      @user = current_user
    end
end
