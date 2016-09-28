require 'sinatra/base'
require 'json'
require 'metrobus'

class App < Sinatra::Base
  set :bind, '0.0.0.0'

  configure do
    set :bus_routes, Metrobus::Route.all
  end

  get '/' do
    erb :home, locals: { bus_routes: settings.bus_routes, stops: nil,
                         directions: nil, departure_text: nil, route_id: '',
                         direction_id: '', stop_id: '' }
  end

  post '/' do
    stops = nil
    directions = nil
    departure_text = nil

    if params['route_id']
      directions = Metrobus::Direction.get(params['route_id'])
    end

    if params['route_id'] && params['direction_id']
      stops = Metrobus::Stop.get(params['route_id'], params['direction_id'])
    end

    if params['route_id'] && params['direction_id'] && params['stop_id']
      departures = Metrobus::Departure.get(params['route_id'], params['direction_id'], params['stop_id'])
      unless departures.empty?
        departure_time = departures[0].get_next_departure_time
        departure_text = "The next bus departs in #{departure_time}"
      else
        departure_text = 'There are no upcoming departures'
      end
    end

    erb :home, locals: { bus_routes: settings.bus_routes, stops: stops,
                        directions: directions, departure_text: departure_text,
                        route_id: params['route_id'], direction_id: params['direction_id'],
                        stop_id: params['stop_id']}
  end
end
