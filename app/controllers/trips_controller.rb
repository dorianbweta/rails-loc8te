class TripsController < ApplicationController
  before_action :set_trip, only: %i[show]
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @trips = Trip.where(user_id: current_user.id)
  end

  def new
    @trip = Trip.new
    @destination = Destination.find
  end

  def create
    start_location = Location.create(address: params[:trip][:start_location])
    end_location = Location.create(address: params[:trip][:end_location])
    @trip = Trip.new(start_location: start_location, end_location: end_location)
    if user_signed_in?
      @trip.user = current_user
    else
      @trip.user = User.find_by_email("visitor@gmail.com")
    end
    if @trip.save
      redirect_to root_path(end: end_location.id)
      # redirect_to trip_rides_path(@trip.id)
    end
  end

  def show
  end

  private

  def trip_params
    params.require(:trip).permit(:start_location_id, :end_location_id)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end
end
