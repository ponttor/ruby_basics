# frozen_string_literal: true

require_relative '../locales/translations'
require_relative '../models/trains/cargo_train'
require_relative '../models/trains/passenger_train'

module TrainsService
  class << self
    def create_train
      number, type = train_data
      create_train_by_type(number, type)
    end

    def create_train_by_type(number, type)
      case type
      when 1
        PassengerTrain.new(number)
      when 2
        CargoTrain.new(number)
      else
        raise Translations::TRAIN[:errors][:wrong_type]
      end
    end

    def select_train_move
      puts Translations::TRAIN[:forward]
      puts Translations::TRAIN[:back]

      gets.to_i
    end

    def process_train_move(trains)
      train = select_train(trains)
      action = select_train_move

      case action
      when 1
        train.move_to_next_station
      when 2
        train.move_to_previous_station
      else
        raise Translations::TRAIN[:errors][:wrong_move]
      end
    end

    def select_train(trains)
      train = Helper.select_from_collection(trains, Translations::TRAIN[:choose], &:number)

      raise Translations::TRAIN[:errors][:invalid_train] if train.nil?

      train
    end

    private

    def train_data
      puts Translations::TRAIN[:number]
      number = gets.chomp

      puts Translations::TRAIN[:type]
      type = gets.to_i

      # capacity = get_capacity(type).to_i

      [number, type]
    end

    # def get_capacity(type)
    #   case type
    #   when 1
    #     puts Translations::TRAIN[:passenger][:total_seats]
    #     gets
    #   when 2
    #     puts Translations::TRAIN[:cargo][:total_volume]
    #     gets
    #   else
    #     raise Translations::TRAIN[:errors][:wrong_type]
    #   end
    # end
  end
end
