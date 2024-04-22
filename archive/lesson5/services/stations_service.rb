require_relative '../locales/translations'

module StationsService
  class << self
    def create_station
      name = get_station_name
      return if name.nil?
      
      station = Station.new(name)
      puts format(Translations::STATION[:created], name)

      station
    end

    def get_stations(available_stations)
      puts Translations::ROUTE[:start]
      start_station_name = gets.chomp
      start_station = find_station_by_name(start_station_name, available_stations)
      return puts Translations::ROUTE[:input_error] unless start_station
  
      puts Translations::ROUTE[:end]
      end_station_name = gets.chomp
      end_station = find_station_by_name(end_station_name, available_stations)
      return puts Translations::ROUTE[:input_error] unless end_station
  
      [start_station, end_station]
    end
  
    def find_station_by_name(name, stations)
      station = stations.find { |s| s.name == name }

      station
    end

    def prompt_for_station(action, available_stations)
      puts format(Translations::STATION[:action], action)
      station_name = gets.chomp

      find_station_by_name(station_name, available_stations).tap do |station|
        puts format(Translations::STATION[:not_found], station_name) unless station
      end
    end
    
    private

    def get_station_name
      puts Translations::STATION[:create]
      name = gets.chomp
      return name unless name.empty?

      puts format(Translations::STATION[:create_failed], name)
    end
  end
end