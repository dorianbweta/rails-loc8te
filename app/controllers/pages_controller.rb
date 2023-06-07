class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @trip = Trip.new
    if params[:end]
      @location = Location.find(params[:end])
    end
  end
end
