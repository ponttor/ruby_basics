# frozen_string_literal: true

require_relative '../modules/instance_counter'
require_relative '../modules/accessor'
require_relative '../modules/validation'

class Station
  include InstanceCounter
  include Accessor
  include Validation

  @@stations = []

  attr_accessor_with_history :trains
  validate :name, :presence
  validate :name, :type, String

  attr_reader :name

  def initialize(name)
    @name = name
    validate!
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

  def each_train(&block)
    trains.each(&block)
  end
end
