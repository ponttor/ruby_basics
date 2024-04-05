require_relative '../vagon'

class CargoVagon < Vagon
  def initialize
    @type = Vagon::CARGO
    super
  end
end