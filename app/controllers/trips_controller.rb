class TripsController < ApplicationController
  def new
    @trip = Trip.new
    @destination = Destination.find
  end
end
