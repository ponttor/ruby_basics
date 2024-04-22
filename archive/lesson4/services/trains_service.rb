require_relative '../locales/translations'
require_relative '../models/trains/cargo_train'
require_relative '../models/trains/passenger_train'

module TrainsService
  class << self
    def create_train
      number, type = get_train_data
      train = create_train_by_type(number, type)

      train
    end

    def create_train_by_type(number, type)
      return puts Translations::TRAIN[:errors][:incorrect_type] if number.nil?
  
      case type
      when 1
        train = PassengerTrain.new(number)
        puts format(Translations::TRAIN[:created], number)
        return train
      when 2
        train = CargoTrain.new(number)
        puts format(Translations::TRAIN[:created], number)
        return train
      else
        puts Translations::TRAIN[:errors][:incorrect_type]
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
        move_to_next_station(train)
      when 2
        move_to_previous_station(train)
      else
        puts Translations::TRAIN[:errors][:invalid_input]
      end
    end
    
    def move_to_next_station(train)
      train.move_to_next_station
      puts Translations::TRAIN[:moved_forward]
    end
    
    def move_to_previous_station(train)
      train.move_to_previous_station
      puts Translations::TRAIN[:moved_back]
    end

    def select_train(trains)
      Helper.select_from_collection(trains, Translations::TRAIN[:choose]) do |train|
        train.number
      end
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