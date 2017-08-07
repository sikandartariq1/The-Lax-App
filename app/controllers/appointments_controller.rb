class AppointmentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_old_salt, only: [:new, :create]
  before_action :check_pending_request, only: [:create]
  before_action :set_appointment, only: [:edit]
  before_action :authenticate_old_salt!, only: [:edit]

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

  def edit
    @appointment.status = params[:status]
    if @appointment.save
      flash[:notice] = "Appointment #{params[:status]}"
    else
      flash[:alert] = "Something went wrong."
    end
    redirect_to old_salt_appointments_path(current_old_salt)
  end

  private

    def appointment_params
      params.require(:appointment).permit(:requested_date, :note, :requested_time, :location, :request_type, :old_salt).merge(old_salt: @old_salt)
    end

    def set_old_salt
      @old_salt = OldSalt.find_by_id(params[:old_salt_id])
      redirect_to old_salts_path, alert: "Old Salt not found." unless @old_salt
    end

    def set_appointment
      @appointment = Appointment.find(params[:id])
      unless Appointment.statuses.include?(params[:status]) && @appointment.pending?
        redirect_to old_salt_appointments_path(current_old_salt), alert: "Invalid Action"
      end
    end

    def check_pending_request
      if current_user.appointments.pending.exists?(old_salt: @old_salt)
        redirect_to user_appointments_path(current_user), alert: "You already have a pending request."
      end
    end

end
