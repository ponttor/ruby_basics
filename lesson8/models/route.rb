# frozen_string_literal: true

require_relative '../modules/instance_counter'

class Route
  include InstanceCounter

  attr_reader :start_station, :end_station
  attr_accessor :intermediate_stations

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @intermediate_stations = []
    register_instance
  end

  def add_station(station)
    intermediate_stations << station
  end

  def remove_station(station)
    intermediate_stations.delete(station)
  end

  def all_stations
    [start_station, *intermediate_stations, end_station]
  end
end
