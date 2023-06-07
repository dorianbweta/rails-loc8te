class TripsController < ApplicationController
  def index
    @trips = Trip.where(user_id: current_user.id)
  end

  def new
    @trip = Trip.new
    @destination = Destination.find
  end
end
