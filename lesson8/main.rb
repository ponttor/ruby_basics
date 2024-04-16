# frozen_string_literal: true

require_relative './models/station'
require_relative './models/route'
require_relative './models/trains/cargo_train'
require_relative './models/vagons/cargo_vagon'
require_relative './models/trains/passenger_train'
require_relative './models/vagons/passenger_vagon'
require_relative './services/stations_service'
require_relative './services/trains_service'
require_relative './services/routes_service'
require_relative './services/vagons_service'
require_relative './services/print_service'
require_relative './utils/helper'
require_relative './locales/translations'
require_relative './modules/validator'

class Interface
  attr_accessor :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def run
    loop do
      show_menu
      begin
        choice = gets.to_i
        take_action(choice)
      rescue StandardError => e
        puts "Error: #{e.message}"
        retry
      end
    end
  end

  private

  def show_menu
    PrintService::MENU.each { |item| puts "#{item[:id]} #{item[:title]}" }
  end

  def take_action(choice)
    item = PrintService::MENU.find { |element| element[:id] == choice }
    raise Translations::MAIN[:errors][:invalid_input] if item.nil?

    send(item[:action])
  end

  def create_station
    create_entity(
      -> { StationsService.create_station },
      Translations::STATION[:created],
      :stations
    )
  end

  def create_train
    create_entity(
      -> { TrainsService.create_train },
      Translations::TRAIN[:created],
      :trains
    )
  end

  def create_entity(service_method, success_message, entity_collection)
    entity = service_method.call
    return unless entity&.valid?

    puts format(success_message, entity.name)
    send(entity_collection) << entity
  end

  def create_route
    routes << RoutesService.create_route(stations)
  end

  def manage_route
    RoutesService.apply_action_to_route(routes, stations)
  end

  def assign_route
    RoutesService.assign_route(trains)
  end

  def add_vagon
    VagonsService.add_vagon_by_type(trains)
  end

  def remove_vagon
    VagonsService.remove_vagon(trains)
  end

  def move_train
    TrainsService.process_train_move(trains)
  end

  def list_stations_and_trains
    PrintService.print_stations_details(stations)
  end

  def list_vagons_of_train
    PrintService.print_vagons_details(trains)
  end

  def list_trains_on_station
    PrintService.print_trains_details(stations)
  end

  def occupy_vagon
    VagonsService.occupy_vagon(trains)
  end

  def seed_data
    # Creating stations
    5.times { |i| stations << Station.new("Station #{i + 1}") }

    # Creating trains
    trains << PassengerTrain.new('112-01') # Passenger train
    trains << CargoTrain.new('221-02') # Cargo train

    # Adding vagons to trains
    3.times { trains[0].attach_vagon(PassengerVagon.new(40)) }  # 3 passenger vagons with 40 seats each
    2.times { trains[1].attach_vagon(CargoVagon.new(1000)) }    # 2 cargo vagons with 1000 cubic meters each

    # Occupying some seats and volume
    trains[0].vagons.each { |vagon| 5.times { vagon.occupy_seat } }
    trains[1].vagons.each { |vagon| vagon.occupy_volume(500) }

    # Creating routes
    routes << Route.new(stations[0], stations[4])
    routes[0].add_station(stations[2])
    routes << Route.new(stations[1], stations[3])

    # Assigning routes to trains
    trains[0].route(routes[0])
    trains[1].route(routes[1])
  end
end
