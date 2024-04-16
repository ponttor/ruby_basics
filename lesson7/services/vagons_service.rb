require_relative '../locales/translations'
require_relative './trains_service'
require_relative '../models/vagons/cargo_vagon'
require_relative '../models/vagons/passenger_vagon'

module VagonsService
  class << self
    def add_vagon_by_type(trains)
      train = TrainsService.select_train(trains)
      capacity = get_capacity

      case train.type
      when Train::PASSENGER
        vagon = PassengerVagon.new(capacity)
        train.attach_vagon(vagon)
      when Train::CARGO
        vagon = CargoVagon.new(capacity)
        train.attach_vagon(vagon)
      else
        raise Translations::VAGON[:errors][:incorrect_type]
      end
    end
  
    def remove_vagon(trains)
      train = TrainsService.select_train(trains)
      vagon = train.vagons.last
      raise Translations::VAGON[:remove][:no_vagons] if vagon.nil?

      train.detach_vagon(vagon)
    end

    def get_capacity
      puts Translations::VAGON[:capacity]
      gets.to_i
    end

    def occupy_vagon(trains)
      train = TrainsService.select_train(trains)
      vagon_index = select_vagon(train.vagons)
      vagon = train.vagons[vagon_index]

      case vagon.type
      when :passenger
        vagon.occupy_seat
      when :cargo
        puts "Enter volume to occupy:"
        volume = gets.to_i
        vagon.occupy_volume(volume)
      else
        raise Translations::VAGON[:errors][:wrong_type]
      end
    end

    def select_vagon(vagons)
      puts "Select a vagon by index:"
      index = gets.to_i - 1
      raise "Invalid vagon index" unless index.between?(0, vagons.size - 1)
      index
    end
  end
end
