class PaymentsController < ApplicationController
  before_action :authenticate_old_salt!, only: [:new, :create]
  before_action :set_user, only: [:new, :create]
  before_action :check_pending_request, only: [:create]

  PAYMENTS_PER_PAGE = 10

  def index
    @payments = current_entity.payments.page(params[:page]).per(PAYMENTS_PER_PAGE)
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = current_old_salt.payments.build(payment_params)
    if @payment.save
      PaymentMailer.payment_request_email(@payment).deliver_later
      redirect_to current_old_salt, notice: "Payment request has been sent successfully"
    else
      render 'new'
    end
  end

  private
    def payment_params
      params.require(:payment).permit(:amount, :payment_user).merge(payment_user: @user)
    end

    def set_user
      @user = User.find_by_id(params[:user_id])
      redirect_to users_path, alert: "User not found." unless @user
    end

    def check_pending_request
      if current_old_salt.payments.pending.exists?(payment_user: @user)
        redirect_to current_old_salt, alert: "You already have a pending request."
      end
    end

end
