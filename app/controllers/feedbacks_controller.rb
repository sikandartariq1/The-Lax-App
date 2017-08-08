class FeedbacksController < ApplicationController
  before_action :authenticate_old_salt!, only: [:new, :create]
  before_action :set_user, only: [:new, :create]
  FEEDBACKS_PER_PAGE = 10

  def index
    @feedbacks = current_entity.feedbacks.page(params[:page]).per(FEEDBACKS_PER_PAGE)
  end

  def show
    @feedback = current_entity.feedbacks.find(params[:id])
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = current_old_salt.feedbacks.build(feedback_params)
    if @feedback.save
      redirect_to old_salt_feedbacks_path(current_old_salt), notice: "Feedback has been sent successfully"
    else
      render 'new'
    end
  end

  private

    def set_user
      @user = User.find_by_id(params[:user_id])
      redirect_to users_path, alert: "User not found." unless @user
    end

    def feedback_params
      params.require(:feedback).permit(:comments, :feedback_user).merge(feedback_user: @user)
    end


end
