class TripsController < ApplicationController
  before_action :set_trip, only: %i[show edit update]
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @trips = Trip.where(user_id: current_user.id)
  end

  def new
    @trip = Trip.new
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
      #redirect_to root_path(end: end_location.id)
       redirect_to trip_path(@trip.id)
    end
  end

  def show;end

  def edit # list of rides for a trip, in this page we're connecting a trip to a ride -> editing and updating trip
    city = City.find_by_name("New York") # in a real scenario we should evaluate the city based on the trip pickup location
    @rides = []
    city.platforms.each do |platform|
      available_rides_per_platform = rand(2..3)

      available_rides_per_platform.times do
        @rides << Ride.new(
          platform: platform,
          ETA: rand(15..25),
          fare: rand(20..100),
          category: Ride::CATEGORIES.sample,
          link_to_app: platform.name == "Uber" ? build_link_to_app(@trip) : ""
        )
      end
    end
  end

  def update
    @ride = Ride.new(platform_id: Platform.last.id, city_id: City.last.id, ETA: 15, fare: 20, category: 'green', link_to_app:build_link_to_app(@trip))
    @uber_ride.link_to_app = build_link_to_app(@trip)
    @uber_ride.user_id = current_user.id
    @uber_ride.save
    @trip.update(ride_id: @uber_ride.id)

    respond_to do |format|
      if @trip.persisted?
        @ok = true
        format.json
        format.html { redirect_to trips_path }
      else
        @ok = false
        format.json
        format.html { render 'trips/show' }
      end
    end

  end

  private

  def trip_params
    params.require(:trip).permit(:start_location_id, :end_location_id)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def build_link_to_app(trip)
    return 'https://m.uber.com/ul/?' +
    'client_id=luRSONXwxNrthicxwvwBXHEtwSovIcxQ' + '&' +
    'action=setPickup' + '&' +
    "pickup[latitude]=#{trip.start_location.latitude}" + '&' +
    "pickup[longitude]=#{trip.start_location.longitude}" + '&' +
    "pickup[nickname]=#{trip.start_location.name}" + '&' +
    "pickup[formatted_address]=#{trip.start_location.address}" + '&' +
    "dropoff[latitude]=#{trip.end_location.latitude}" + '&' +
    "dropoff[longitude]=#{trip.end_location.longitude}" + '&' +
    "dropoff[nickname]=#{trip.end_location.address}" + '&' +
    "dropoff[formatted_address]=#{trip.end_location.address}" + '&' +
    'product_id=a1111c8c-c720-46c3-8534-2fcdd730040d'
  end
end
