require_relative '../modules/manufacturer'

class Vagon
  include Manufacturer
  attr_reader :type

  CARGO = :cargo
  PASSENGER = :passenger
end