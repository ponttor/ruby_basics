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

class Interface
  MENU = [
    {id: 1, title: 'Create a new station', action: :create_station},
    {id: 2, title: 'Create a new train', action: :create_train},
    {id: 3, title: 'Create a new route', action: :create_route},
    {id: 4, title: 'Manage route', action: :manage_route},
    {id: 5, title: 'Assign route to a train', action: :assign_route},
    {id: 6, title: 'Add vagon to a train', action: :add_vagon},
    {id: 7, title: 'Remove vagon from a train', action: :remove_vagon},
    {id: 8, title: 'Move the train along the route', action: :move_train},
    {id: 9, title: 'View the list of stations and trains at the station', action: :list_stations_and_trains},
    {id: 0, title: 'Exit', action: nil},
  ].freeze

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
    return puts Translations::MAIN.errors.invalid_input if item.nil?

    send(item[:action])
  end

  def create_station
    stations << StationsService.create_station
  end

  def create_train
    trains << TrainsService.create_train
  end

  def create_route
    routes << RoutesService.create_route(stations)
  end

  def manage_route
    route = RoutesService.select_route(routes)
    action = RoutesService.show_routes_actions

    RoutesService.apply_action_to_route(route, action, stations)
  end

  def assign_route
    train = TrainsService.select_train(trains)
    route = RoutesService.select_route(routes)

    train.set_route(route)
  end

  def add_vagon
    train = TrainsService.select_train(trains)
    VagonsService.add_vagon_by_type(train)  
  end

  def remove_vagon
    train = TrainsService.select_train(trains)
    return puts 'The train has no vagons.' if train.vagons.empty?

    VagonsService.remove_vagon(train)
  end

  def move_train
    train = TrainsService.select_train(trains)
    action = TrainsService.select_train_move
    TrainsService.process_train_move(train, action)
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
