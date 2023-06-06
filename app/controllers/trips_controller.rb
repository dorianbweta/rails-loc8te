class TripsController < ApplicationController
  def new
    @trip = Trip.new
    @destination = Destination.find
  end

  def create
    @trip = Trip.new(trip_params)
    if user_signed_in?
      @trip.user = current_user
    else
      @trip.user = User.find_by_email("visitor@gmail.com")
    end
    if @trip.save
      redirect_to trip_rides_path(@trip.id)
    end
  end

  def trip_params
    params.require(:trip).permit(:start_location_id, :end_location_id)
  end
end
