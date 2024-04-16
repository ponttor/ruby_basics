# frozen_string_literal: true

require_relative '../locales/translations'
require_relative './trains_service'
require_relative '../models/vagons/cargo_vagon'
require_relative '../models/vagons/passenger_vagon'

module VagonsService
  class << self
    def add_vagon_by_type(trains)
      train = TrainsService.select_train(trains)
      capacity = get_capacity
      add_vagon_to_train(train, capacity)
    end

    def add_vagon_to_train(train, capacity)
      case train.type
      when Train::PASSENGER
        add_passenger_vagon(train, capacity)
      when Train::CARGO
        add_cargo_vagon(train, capacity)
      else
        raise Translations::VAGON[:errors][:incorrect_type]
      end
    end

    def add_passenger_vagon(train, capacity)
      vagon = PassengerVagon.new(capacity)
      train.attach_vagon(vagon)
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

      process_vagon_occupation(vagon)
    end

    def process_vagon_occupation(vagon)
      case vagon.type
      when :passenger
        occupy_passenger_vagon(vagon)
      when :cargo
        occupy_cargo_vagon(vagon)
      else
        raise Translations::VAGON[:errors][:wrong_type]
      end
    end

    def occupy_passenger_vagon(vagon)
      vagon.occupy_seat
    end

    def occupy_cargo_vagon(vagon)
      puts 'Enter volume to occupy:'
      volume = gets.to_i
      vagon.occupy_volume(volume)
    end

    def select_vagon(vagons)
      puts 'Select a vagon by index:'
      index = gets.to_i - 1
      raise 'Invalid vagon index' unless index.between?(0, vagons.size - 1)

      index
    end
  end
end
