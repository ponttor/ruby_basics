# frozen_string_literal: true

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

      train.route(route)
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
        add_station_to_route(route, stations)
      when 2
        remove_station_from_route(route, stations)
      else
        raise Translations::ROUTE[:errors][:invalid_input]
      end
    end

    def add_station_to_route(route, stations)
      station = StationsService.prompt_for_station(Translations::ROUTE[:adding], stations)
      route.add_station(station) if station
    end

    def remove_station_from_route(route, stations)
      station = StationsService.prompt_for_station(Translations::ROUTE[:removal], stations)
      route.remove_station(station) if station
    end

    def select_route(routes)
      route_info = Helper.select_from_collection(routes, Translations::ROUTE[:select_route]) do |route|
        "#{route.start_station.name} – #{route.end_station.name}"
      end
      raise Translations::ROUTE[:errors][:invalid_route] if route_info.nil?

      route_info
    end
  end
end
