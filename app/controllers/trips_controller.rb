class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  def index
  end

  def new
    @trip = Trip.new
    @destination = Destination.find
  end
end
