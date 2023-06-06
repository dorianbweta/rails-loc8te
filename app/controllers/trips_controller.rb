class TripsController < ApplicationController
  before_action :set_trip, only: %i[show]
  skip_before_action :authenticate_user!, only: %i[index]

  def index
  end

  def new
    @trip = Trip.new
    @destination = Destination.find
  end

  def show
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end
end
