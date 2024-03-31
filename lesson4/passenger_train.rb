require_relative 'train'

class PassengerTrain < Train
  private

  def can_attach_vagon?(vagon)
    vagon.is_a?(PassengerVagon)
  end
end