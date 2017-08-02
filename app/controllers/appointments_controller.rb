class AppointmentsController < ApplicationController
  APPOINTMENTS_PER_PAGE = 10
  def index
    current_entity = current_user || current_old_salt
    @appointments = current_entity.appointments.page(params[:page]).per(APPOINTMENTS_PER_PAGE)
  end
end
