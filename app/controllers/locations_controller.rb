class LocationsController < ApplicationController
  def update
    @location = Location.find(params[:id])
    @location.update(location_params)
    redirect_to root_path
  end

  private

  def location_params
    params.require(:location).permit(:name)
  end
end
