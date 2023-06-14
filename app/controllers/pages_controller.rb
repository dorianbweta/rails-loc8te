class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, 'trips#search']

  def home
    @trip = Trip.new
    if params[:end]
      @location = Location.find(params[:end])
    end
  end
end
