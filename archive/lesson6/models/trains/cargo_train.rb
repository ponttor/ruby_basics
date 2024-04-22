require_relative '../train'

class CargoTrain < Train
  def initialize(number)
    @type = Train::CARGO
    super
  end
end