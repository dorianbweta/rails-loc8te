class LocationsController < ApplicationController
  def update
    @location = Location.find(params[:id])
    @location.update(location_params)
    redirect_to trips_search_path
  end

  def edit
    @location = Location.find(params[:id])
  end

  private

  def location_params
    params.require(:location).permit(:name)
  end
end
