class LocationsController < ApplicationController
  before_action :authenticate_teacher!, only: [:create, :destroy]
  def create
    @location = current_teacher.locations.build(location_params)
    if @location.save
      respond_to do |format|
        format.html {redirect_to teachers_locations_url, notice: "New location created! "}
      end
    else
      respond_to do |format|
        format.html {render :'pages/teacher_locations', alert: "Cannot creat new location!"}
      end
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    respond_to do |format|
      format.html {redirect_to teachers_locations_url, notice: 'Location was successfully destroyed.'}
    end
  end

  private
  def location_params
    params.require(:location).permit([:start_time, :end_time, :weekday, :place])
  end
end
