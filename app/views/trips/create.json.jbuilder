# The 'create.json.jbuilder' file is used to build a JSON response when a new trip is created.
# It specifies that the response should have an 'ok' status,
# redirect to the 'trips_path', and include a 'link_to_app' attribute
# that is obtained from the '@selected_ride.link_to_app' variable.

json.ok @ok
json.redirect trips_path
json.link_to_app @selected_ride.link_to_app
