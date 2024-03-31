require_relative 'train'

class CargoTrain < Train
  private

  def can_attach_vagon?(vagon)
    vagon.is_a?(CargoVagon)
  end
end