require_relative '../train'

class PassengerTrain < Train

  def initialize(number)
    @type = Train::PASSENGER
    super
  end
end