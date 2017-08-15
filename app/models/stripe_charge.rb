class StripeCharge
  attr_reader :params, :payment
  APPLICATION_FEE_PERCENTAGE = 0.02

  def initialize(params, payment)
    @params = params
    @payment = payment
  end

  def create_charge
    charge = Stripe::Charge.create(
      { amount: amount_in_cents.to_i,
        currency: :USD,
        source: params[:stripeToken],
        application_fee: application_fee.to_i
      },
      stripe_account: payment.payment_old_salt.stripe_account_id
    )
    update_status
  end

  private
    def amount_in_cents
      payment.amount * 100
    end

    def update_status
      payment.paid!
    end

    def application_fee
      APPLICATION_FEE_PERCENTAGE * amount_in_cents
    end
end
