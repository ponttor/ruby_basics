# frozen_string_literal: true

require_relative '../vagon'
require_relative '../../locales/translations'

class CargoVagon < Vagon
  attr_reader :total_volume, :occupied_volume

  def initialize(total_volume)
    super()
    @type = Vagon::CARGO
    @total_volume = total_volume
    validate!
    @occupied_volume = 0
  end

  def occupy_volume(volume)
    raise 'No more capacity' if occupied_volume + volume > total_volume

    @occupied_volume += volume
  end

  def free_volume
    total_volume - occupied_volume
  end

  private

  def validate!
    raise 'Total volume must be a positive number.' unless total_volume.positive?
  end
end
