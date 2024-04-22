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
require_relative './utils/helper'
require_relative './locales/translations'
require_relative './modules/validator'

MENU = [
  {id: 1, title: 'Create a new station', action: :create_station},
  {id: 2, title: 'Create a new train', action: :create_train},
  {id: 3, title: 'Create a new route', action: :create_route},
  {id: 4, title: 'Manage a route', action: :manage_route},
  {id: 5, title: 'Assign a route to a train', action: :assign_route},
  {id: 6, title: 'Add a vagon to a train', action: :add_vagon},
  {id: 7, title: 'Remove a vagon from a train', action: :remove_vagon},
  {id: 8, title: 'Move the train along the route', action: :move_train},
  {id: 9, title: 'View the list of stations and trains at the station', action: :list_stations_and_trains},
  {id: 0, title: 'Exit', action: nil},
].freeze

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
      action = take_action(gets.to_i)
      return if action.nil?
    end
  end

  private

  def show_menu
    MENU.each do |item|
      puts "#{item[:id]} #{item[:title]}"
    end
  end

  def take_action(choice)
    return nil if choice.zero?

    item = MENU.find { |item| item[:id] == choice }
    return puts Translations::MAIN[:errors][:invalid_input] if item.nil?

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
    begin
      entity = service_method.call
      if entity&.valid?
        puts format(success_message, entity.name)
        send(entity_collection) << entity
      end
    rescue StandardError => e
      puts "Error: #{e.message}"
      retry
    end
  end

  def create_route
    begin
      routes << RoutesService.create_route(stations)
    rescue StandardError => e
      puts "Error: #{e.message}"
      retry
    end
  end

  def manage_route
    begin
      route = RoutesService.select_route(routes)
      action = RoutesService.show_routes_actions
      RoutesService.apply_action_to_route(route, action, stations)
    rescue StandardError => e
      puts "Error: #{e.message}"
      retry
    end
  end

  def assign_route
    begin
      train = TrainsService.select_train(trains)
      route = RoutesService.select_route(routes)
      train.set_route(route)
    rescue StandardError => e
      puts "Error: #{e.message}"
      retry
    end
  end

  def add_vagon
    begin
      train = TrainsService.select_train(trains)
      VagonsService.add_vagon_by_type(train)
    rescue StandardError => e
      puts "Error: #{e.message}"
      retry
    end
  end

  def remove_vagon
    begin
      train = TrainsService.select_train(trains)
      VagonsService.remove_vagon(train)
    rescue StandardError => e
      puts "Error: #{e.message}"
      retry
    end
  end

  def move_train
    begin
      train = TrainsService.select_train(trains)
      action = TrainsService.select_train_move
      TrainsService.process_train_move(train, action)
    rescue StandardError => e
      puts "Error: #{e.message}"
      retry
    end
  end
  
  def list_stations_and_trains
    stations.each do |station|
      puts "Station: #{station.name}"
      station.trains.each do |train|
        puts "  Train №#{train.number}, type: #{train.class}, number of vagons: #{train.vagons.size}"
      end
    end
  end
end
