class FeedbacksController < ApplicationController

  def show
    @feedback = current_entity.feedbacks.find(params[:id])
  end

end
