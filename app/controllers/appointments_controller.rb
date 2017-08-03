class AppointmentsController < ApplicationController

  APPOINTMENTS_PER_PAGE = 10

  def index
    @appointments = current_entity.appointments.page(params[:page]).per(APPOINTMENTS_PER_PAGE)
  end

  def show
    @appointment = current_entity.appointments.find(params[:id])
  end

  private

    def current_entity
      current_user || current_old_salt
    end

end
