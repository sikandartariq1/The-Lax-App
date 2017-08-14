class PaymentsController < ApplicationController
  PAYMENTS_PER_PAGE = 10

  def index
    @payments = current_entity.payments.page(params[:page]).per(PAYMENTS_PER_PAGE)
  end

end
