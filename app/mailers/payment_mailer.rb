class PaymentMailer < ApplicationMailer
  default from: "notification@laxapp.com"

  def payment_request_email(payment)
    @payment = payment
    mail(to: @payment.payment_user.email, subject: 'Payment Request')
  end

  def payment_sent_email(payment)
    @payment = payment
    mail(to: @payment.payment_old_salt.email, subject: 'Payment Request')
  end

end
