require_relative '../locales/translations'

module StationsService
  class << self
    def create_station
      name = get_station_name
      Station.new(name)
    end

    def get_stations(available_stations)
      puts Translations::ROUTE[:start]
      start_station_name = gets.chomp
      start_station = find_station_by_name(start_station_name, available_stations)
  
      puts Translations::ROUTE[:end]
      end_station_name = gets.chomp
      end_station = find_station_by_name(end_station_name, available_stations)
  
      [start_station, end_station]
    end
  
    def find_station_by_name(name, stations)
      station = stations.find { |s| s.name == name }

      raise format(Translations::STATION[:not_found], name) if station.nil?

      station
    end

    def prompt_for_station(action, available_stations)
      puts format(Translations::STATION[:action], action)
      station_name = gets.chomp
      station = find_station_by_name(station_name, available_stations)

      raise format(Translations::STATION[:errors][:not_found]) if station.nil?

      station
    end
    
    private

    def get_station_name
      puts Translations::STATION[:ask_name]
      gets.chomp
    end
  end
end