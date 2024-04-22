class Train
  attr_accessor :speed, :vagons_number
  attr_reader :number, :type

  def initialize(number, type, vagons_number)
    @number = number
    @type = type
    @vagons_number = vagons_number
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def attach_vagon
    @vagons_number += 1 if @speed == 0
  end

  def detach_vagon
    @vagons_number -= 1 if @speed == 0 && @vagons_number > 0
  end

  def set_route(route)
    @current_station.send_train(self) if @current_station
    @route = route
    @current_station_index = 0
    current_station.accept_train(self)
    @current_station = current_station
  end

  def previous_station
    @route.all_stations[@current_station_index - 1] if @current_station_index > 0
  end

  def next_station
    @route.all_stations[@current_station_index + 1] if @current_station_index < @route.all_stations.length - 1
  end

  def current_station
    @route.all_stations[@current_station_index]
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
end