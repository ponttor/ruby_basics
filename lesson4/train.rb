class Train
  attr_accessor :speed
  attr_reader :number, :vagons

  def initialize(number)
    @number = number
    @vagons = []
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def attach_vagon(vagon)
    puts 'Cannot attach this type of vagon to the train' unless can_attach_vagon?(vagon) && @speed == 0

    @vagons.push(vagon)
    puts 'The vagon has been attached'
  end

  def detach_vagon(vagon)
    @vagons.delete(vagon) if @speed == 0
  end

  def set_route(route)
    @current_station.send_train(self) if @current_station
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

  private

  def previous_station
    @route.all_stations[@current_station_index - 1] if @current_station_index > 0
  end

  def next_station
    @route.all_stations[@current_station_index + 1] if @current_station_index < @route.all_stations.length - 1
  end

  def current_station
    @route.all_stations[@current_station_index]
  end

  def can_attach_vagon?(vagon)
    false
  end
end