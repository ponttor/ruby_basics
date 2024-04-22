require_relative '../locales/translations'
require_relative './trains_service'
require_relative '../models/vagons/cargo_vagon'
require_relative '../models/vagons/passenger_vagon'

module VagonsService
  class << self
    def add_vagon_by_type(train)
      case train.type
      when Train::PASSENGER
        train.attach_vagon(PassengerVagon.new)
      when Train::CARGO
        train.attach_vagon(CargoVagon.new)
      else
        raise Translations::VAGON[:errors][:incorrect_type]
      end
    end
  
    def remove_vagon(train)
      vagon = train.vagons.last
      raise Translations::VAGON[:remove][:no_vagons] if vagon.nil?

      train.detach_vagon(vagon)
    end
  end
end
