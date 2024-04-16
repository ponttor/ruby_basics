require_relative './stations_service'
require_relative '../locales/translations'
require_relative '../utils/helper'
require_relative '../models/route'

module RoutesService
  class << self
    def create_route(available_stations)
      start_station, end_station = StationsService.get_stations(available_stations)
      Route.new(start_station, end_station)
    end

    def assign_route
      train = TrainsService.select_train(trains)
      route = RoutesService.select_route(routes)

      train.set_route(route)
    end

    def show_routes_actions
      puts Translations::ROUTE[:add]
      puts Translations::ROUTE[:remove]
  
      gets.to_i
    end
  
    def apply_action_to_route(routes, stations)
      route = select_route(routes)
      action = show_routes_actions

      case action
      when 1
        station = StationsService.prompt_for_station(Translations::ROUTE[:adding], stations)
        route.add_station(station) if station
      when 2
        station = StationsService.prompt_for_station(Translations::ROUTE[:removal], stations)
        route.remove_station(station) if station
      else
        raise Translations::ROUTE[:errors][:invalid_input]
      end
    end

    def select_route(routes)
      route = Helper.select_from_collection(routes, Translations::ROUTE[:select_route]) do |route|
        "#{route.start_station.name} – #{route.end_station.name}"
      end
      raise Translations::ROUTE[:errors][:invalid_route] if route.nil?

      route
    end
  end
end