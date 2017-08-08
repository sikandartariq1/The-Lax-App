class AppointmentMailer < ApplicationMailer
  default from: "notification@laxapp.com"

  def appointment_request_email(appointment)
    @appointment = appointment
    mail(to: @appointment.old_salt.email, subject: 'Appointment Request')
  end

end
