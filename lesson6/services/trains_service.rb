require_relative '../locales/translations'
require_relative '../models/trains/cargo_train'
require_relative '../models/trains/passenger_train'

module TrainsService
  class << self
    def create_train
      number, type = get_train_data
      create_train_by_type(number, type)
    end

    def create_train_by_type(number, type)
      case type
      when 1
        return PassengerTrain.new(number)
      when 2
        return CargoTrain.new(number)
      else
        raise Translations::TRAIN[:errors][:wrong_type]
      end
    end

    def select_train_move
      puts Translations::TRAIN[:forward]
      puts Translations::TRAIN[:back]

      gets.to_i
    end
    
    def process_train_move(train, action)
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
      train = Helper.select_from_collection(trains, Translations::TRAIN[:choose]) do |train|
        train.number
      end

      raise Translations::TRAIN[:errors][:invalid_train] if train.nil?

      train
    end

    private

    def get_train_data
      puts Translations::TRAIN[:number]
      number = gets.chomp
  
      puts Translations::TRAIN[:type]
      type = gets.to_i
  
      [number, type]
    end
  end
end