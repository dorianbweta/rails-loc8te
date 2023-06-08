class TripsController < ApplicationController
  before_action :set_trip, only: %i[show update]
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
    # create new rides (Uber, Lyft, Grab)
    @uber_ride = Ride.new(platform_id: 1, city_id: 1, ETA: 15, fare: 20, category: 'green', link_to_app:'')
    @lyft_ride = Ride.new(platform_id: 2, city_id: 1, ETA: 15, fare: 20, category: 'green', link_to_app:'')
    @arro_ride = Ride.new(platform_id: 3, city_id: 1, ETA: 15, fare: 20, category: 'green', link_to_app:'')

    # uber_ride.link = uber_link with pre-filled data from trip
    
    #VIEW
    # form with the new ride options
    # confirmation button -> update the trip and the ride in DB + redirect to Uber
  end

  def update
    @uber_ride = Ride.new(platform_id: Platform.last.id, city_id: City.last.id, ETA: 15, fare: 20, category: 'green', link_to_app:'')
    @uber_ride.link_to_app = build_link_to_app(@trip)
    @uber_ride.user_id = current_user.id
    @uber_ride.save
    @trip.update(ride_id: @uber_ride.id)

    redirect_to @uber_ride.link_to_app, allow_other_host: true
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
