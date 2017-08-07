class AppointmentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_old_salt, only: [:new, :create]
  before_action :check_pending_request, only: [:create]
  APPOINTMENTS_PER_PAGE = 10

  def index
    @appointments = current_entity.appointments.page(params[:page]).per(APPOINTMENTS_PER_PAGE)
  end

  def show
    @appointment = current_entity.appointments.find(params[:id])
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = current_user.appointments.build(appointment_params)
    if @appointment.save
      redirect_to user_appointments_path(current_user), notice: "Appointment request has been sent successfully"
    else
      render 'new'
    end
  end

  private

    def appointment_params
      params.require(:appointment).permit(:requested_date, :note, :requested_time, :location, :request_type, :old_salt).merge(old_salt: @old_salt)
    end

    def set_old_salt
      @old_salt = OldSalt.find_by_id(params[:old_salt_id])
      redirect_to old_salts_path, alert: "Old Salt not found." unless @old_salt
    end

end
