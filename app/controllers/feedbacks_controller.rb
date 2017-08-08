class FeedbacksController < ApplicationController
  FEEDBACKS_PER_PAGE = 10

  def index
    @feedbacks = current_entity.feedbacks.page(params[:page]).per(FEEDBACKS_PER_PAGE)
  end

  def show
    @feedback = current_entity.feedbacks.find(params[:id])
  end

end
