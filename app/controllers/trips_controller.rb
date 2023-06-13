class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @trips = Trip.where(user_id: current_user.id)
  end

  # create a new trip WITHOUT saving in DB
  def search
    @trip = Trip.new
    @histories = Trip.where(user_id: current_user.id)
    @locations = current_user.end_locations.where.not(name: nil)
  end

  def new # list of rides for a trip, in this page we're connecting a trip to a ride -> editing and updating trip
    @start_location = Location.create(address: params[:trip][:start_location])
    @end_location = Location.create(address: params[:trip][:end_location])
    @start_array = [@start_location.longitude, @start_location.latitude]
    @end_array = [@end_location.longitude, @end_location.latitude]
    @trip = Trip.new(start_location: @start_location, end_location: @end_location)
    if user_signed_in?
      @trip.user = current_user
    else
      @trip.user = User.find_by_email("visitor@gmail.com")
    end

    # generates an array of rides that I pass to the 'trip_create_controller.js' via the 'new' view
    city = City.find_by_name("New York") # in a real scenario we should evaluate the city based on the trip pickup location
    @rides = []
    city.platforms.each do |platform|
      available_rides_per_platform = rand(2..3)
      available_rides_per_platform.times do
        @rides << Ride.new(
          platform: platform,
          city: city,
          ETA: rand(15..25),
          fare: rand(20..100),
          category: Ride::CATEGORIES.sample,
          link_to_app: platform.name == "Uber" ? build_link_to_app(@trip) : ""
        )
      end
    end
  end

  def create
    puts selected_ride_index = params[:index].to_i
    puts @selected_ride = Ride.new(params[:ride][selected_ride_index])
    @selected_ride.user_id = current_user.id
    @selected_ride.save
    puts @trip = Trip.new(
      start_location: Location.find(params[:trip_start].to_i),
      end_location: Location.find(params[:trip_end].to_i),
      user_id: params[:trip_user].to_i
    )
    @trip.update(ride_id: @selected_ride.id)
    puts @trip
    raise

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

    if @trip.save
      redirect_to trips
    end
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  # def ride_params
  #   params.require(:ride).permit(:platform, :city, :ETA, :fare, :category, :link_to_app)
  # end

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
