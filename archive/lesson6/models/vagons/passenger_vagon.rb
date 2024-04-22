require_relative '../vagon'

class PassengerVagon < Vagon
  def initialize
    @type = Vagon::PASSENGER
    super
  end
end