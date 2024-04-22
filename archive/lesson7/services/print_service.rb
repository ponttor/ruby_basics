require_relative '../locales/translations'
require_relative './trains_service'
require_relative './stations_service'

module PrintService
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
    {id: 10, title: 'View the list of vagons of train', action: :list_vagons_of_train},
    {id: 11, title: 'View the list of trains on stations', action: :list_trains_on_station},
    {id: 12, title: 'Occupy vagon', action: :occupy_vagon},
    {id: 13, title: 'Seed initial data', action: :seed_data},
    {id: 0, title: 'Exit', action: nil},
  ].freeze

  class << self
    def print_stations_details(stations)
      stations.each { |station| print_station_details(station) }
    end

    def print_station_details(station)
      puts "Station: #{station.name}"
      station.trains.each { |train| print_train_details(train) }
    end
    
    def print_trains_details(stations)
      station = StationsService.select_station(stations)
      station.trains.each { |train| print_train_details(train)}
    end

    def print_train_details(train)
      puts "  Train №#{train.number}, type: #{train.type}, number of wagons: #{train.vagons.size}"
      train.each_vagon { |vagon| print_vagon_details(vagon) }
    end

    def print_vagons_details(trains)
      train = TrainsService.select_train(trains)
      raise 'No vagons yet' if train.vagons.empty?

      train.each_vagon { |vagon| print_vagon_details(vagon) }
    end

    def print_vagon_details(vagon)
      if vagon.type == :passenger
        puts "Type: #{vagon.type}, Free Seats: #{vagon.free_seats}, Occupied Seats: #{vagon.occupied_seats}"
      elsif vagon.type == :cargo
        puts "Type: #{vagon.type}, Free Volume: #{vagon.free_volume}, Occupied Volume: #{vagon.occupied_volume}"
      end
    end
  end
end
