# frozen_string_literal: true

require_relative '../vagon'
require_relative '../../locales/translations'

class PassengerVagon < Vagon
  attr_reader :total_seats, :occupied_seats

  def initialize(total_seats)
    super()
    @type = Vagon::PASSENGER
    @total_seats = total_seats
    validate!
    @occupied_seats = 0
  end

  def occupy_seat
    raise 'No more seats available' if occupied_seats >= total_seats

    @occupied_seats += 1
  end

  def free_seats
    total_seats - occupied_seats
  end

  private

  def validate!
    raise 'Total seats must be a positive number' unless total_seats.positive?
  end
end
