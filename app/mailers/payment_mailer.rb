class PaymentMailer < ApplicationMailer
  default from: "notification@laxapp.com"

  def payment_request_email(payment)
    @payment = payment
    mail(to: @payment.payment_user.email, subject: 'Payment Request')
  end

end
