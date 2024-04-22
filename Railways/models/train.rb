# frozen_string_literal: true

require_relative '../locales/translations'
require_relative '../modules/instance_counter'
require_relative '../modules/manufacturer'
require_relative '../modules/validation'
require_relative '../modules/accessor'
require_relative './vagon'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  include Accessor

  @@trains = []

  attr_accessor_with_history :speed
  strong_attr_accessor :vagons, Vagon

  CARGO = :cargo
  PASSENGER = :passenger
  NUMBER_FORMAT = /^[A-Za-z0-9]{3}-?[A-Za-z0-9]{2}$/

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  attr_reader :number, :type

  def initialize(number)
    @number = number
    validate!
    @vagons = []
    @speed = 0
    @@trains << self
    register_instance
  end

  def self.find(number)
    @@trains.find { |train| train.number.to_i == number }
  end

  def self.all
    @@trains
  end

  def stop
    0
  end

  def name
    number
  end

  def attach_vagon(vagon)
    raise Translations::VAGON[:errors][:wrong_type] unless can_attach_vagon?(vagon) && speed.zero?

    vagons.push(vagon)
  end

  def detach_vagon(vagon)
    vagons.delete(vagon) if speed.zero?
  end

  def route(route)
    @current_station&.send_train(self)
    @route = route
    @current_station_index = 0
    current_station.accept_train(self)

    @current_station = current_station
  end

  def move_to_next_station
    return if next_station.nil?

    current_station.send_train(self)
    @current_station_index += 1
    current_station.accept_train(self)
    @current_station = current_station
  end

  def move_to_previous_station
    return if previous_station.nil?

    current_station.send_train(self)
    @current_station_index -= 1
    current_station.accept_train(self)
    @current_station = current_station
  end

  def each_vagon(&block)
    vagons.each(&block)
  end

  private

  def previous_station
    @route.all_stations[@current_station_index - 1] if @current_station_index.positive?
  end

  def next_station
    @route.all_stations[@current_station_index + 1] if @current_station_index < @route.all_stations.length - 1
  end

  def current_station
    @route.all_stations[@current_station_index]
  end

  def can_attach_vagon?(vagon)
    vagon.type == type
  end
end
