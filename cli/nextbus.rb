#!/usr/bin/env ruby

require 'metrobus'

route_name = ARGV[0]
stop_name = ARGV[1]
direction = ARGV[2]

def bail(message)
  puts message
  exit 1
end

found_routes = Metrobus::Route.find(route_name)

if found_routes.length == 0
  bail("No routes were found for #{route_name}")
elsif found_routes.length > 1
  message = "Found the following routes:\n"
  message +=  "*" * 25 + "\n"
  found_routes.each { |route| message += route.description + "\n" }
  message +=  "*" * 25 + "\n"
  message += "Please narrow down your selection."
  bail(message)
end

route = found_routes[0]
real_route_name = route.description

direction_id = route.get_direction_id(direction)
bail("The direction #{direction} id not valid for route #{real_route_name}") unless direction_id

found_stops = Metrobus::Stop.find(stop_name, route.route, direction_id)

if found_stops.length == 0
  bail("No stops were found for #{stop_name} on route #{real_route_name} going #{direction}")
elsif found_stops.length > 1
  message = "Found the following stops:\n"
  message +=  "*" * 25 + "\n"
  found_stops.each { |stop| message += stop.stop_name + "\n" }
  message +=  "*" * 25 + "\n"
  message += "Please narrow down your selection."
  bail(message)
end

stop_id = found_stops[0].stop_id
real_stop_name = found_stops[0].stop_name

departures = Metrobus::Departure.get(route.route, direction_id, stop_id)

bail("There are no upcoming departures for #{real_stop_name} on route #{real_route_name} going #{direction}") if departures.empty?
puts "The next bus from #{real_stop_name} on #{real_route_name} traveling #{direction} departs in #{departures[0].get_next_departure_time}"
