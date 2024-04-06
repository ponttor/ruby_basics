require_relative '../modules/instance_counter'


class Station
  include InstanceCounter

  @@stations = []
  
  attr_reader :name
  attr_accessor :trains

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end

  def accept_train(train)
    trains << train
  end

  def trains_names
    trains.map(&:number)
  end

  def trains_by_type(type)
    trains.count { |train| train.type == type }
  end

  def send_train(train)
    trains.delete(train)
  end
end
