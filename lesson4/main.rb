require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'cargo_vagon'
require_relative 'passenger_train'
require_relative 'passenger_vagon'

class Interface
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def run
    loop do
      puts 'Выберите действие:'
      puts '1. Создать станцию'
      puts '2. Создать поезд'
      puts '3. Создать маршрут'
      puts '4. Управление маршрутом'
      puts '5. Назначить маршрут поезду'
      puts '6. Добавить вагоны к поезду'
      puts '7. Отцепить вагоны от поезда'
      puts '8. Переместить поезд по маршруту'
      puts '9. Просмотреть список станций и поездов на станции'
      puts '0. Выход'

      choice = gets.to_i

      case choice
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then manage_route
      when 5 then assign_route
      when 6 then add_vagon
      when 7 then remove_vagon
      when 8 then move_train
      when 9 then list_stations_and_trains
      when 0 then break
      else
        puts 'Некорректный ввод, попробуйте еще раз.'
      end
    end
  end

  private

  def create_station
    puts 'Введите название станции:'
    name = gets.chomp

    @stations << Station.new(name)
    puts "Станция '#{name}' создана."
  end

  def create_train
    puts 'Введите номер поезда:'
    number = gets.chomp

    puts 'Выберите тип поезда: 1 - пассажирский, 2 - грузовой'
    type = gets.to_i

    case type
    when 1
      @trains << PassengerTrain.new(number)
      puts "Пассажирский поезд №#{number} создан."
    when 2
      @trains << CargoTrain.new(number)
      puts "Грузовой поезд №#{number} создан."
    else
      puts 'Некорректный тип поезда.'
    end
  end

  def create_route
    puts 'Введите начальную станцию маршрута:'
    start_station_name = gets.chomp
    start_station = find_station_by_name(start_station_name)
    return puts 'Ошибка ввода' unless start_station

    puts 'Введите конечную станцию маршрута:'
    end_station_name = gets.chomp
    end_station = find_station_by_name(end_station_name)
    return puts 'Ошибка ввода' unless end_station
    
    @routes << Route.new(start_station, end_station) 
    puts "Маршрут от #{start_station.name} до #{end_station.name} создан."
  end

  def find_station_by_name(name)
    station = @stations.find { |s| s.name == name }
    return station if station
    
    puts "Станция '#{name}' не найдена."
  end

  def manage_route
    route = select_route
    puts '1. Добавить станцию в маршрут'
    puts '2. Удалить станцию из маршрута'
    action = gets.to_i

    case action
    when 1
      station = prompt_for_station('добавления')
      route.add_station(station) if station
    when 2
      station = prompt_for_station('удаления')
      route.remove_station(station) if station
    else
      puts 'Некорректный ввод.'
    end
  end

  def prompt_for_station(action)
    puts "Введите название станции для #{action}:"
    station_name = gets.chomp
    find_station_by_name(station_name).tap do |station|
      puts "Станция '#{station_name}' не найдена." unless station
    end
  end

  def assign_route
    train = select_train
    route = select_route
    train.set_route(route)
    puts "Маршрут успешно назначен поезду #{train.number}."
  end

  def add_vagon
    train = select_train
    if train.is_a?(PassengerTrain)
      train.attach_vagon(PassengerVagon.new)
    elsif train.is_a?(CargoTrain)
      train.attach_vagon(CargoVagon.new)
    end
    puts "Вагон добавлен к поезду #{train.number}."
  end

  def remove_vagon
    train = select_train
    return puts 'У поезда нет вагонов.' if train.vagons.empty?

    vagon = train.vagons.last
    train.detach_vagon(vagon)
    puts "Вагон отцеплен от поезда #{train.number}."
  end

  def move_train
    train = select_train
    puts '1. Переместить поезд на следующую станцию'
    puts '2. Переместить поезд на предыдущую станцию'
    action = gets.to_i

    case action
    when 1
      train.move_to_next_station
      puts 'Поезд перемещен на следующую станцию.'
    when 2
      train.move_to_previous_station
      puts 'Поезд перемещен на предыдущую станцию.'
    else
      puts 'Некорректный ввод.'
    end
  end

  def list_stations_and_trains
    @stations.each do |station|
      puts "Станция: #{station.name}"
      station.trains.each do |train|
        puts "  Поезд №#{train.number}, тип: #{train.class}, количество вагонов: #{train.vagons.size}"
      end
    end
  end

  def select_from_collection(collection, prompt)
    puts prompt
    collection.each_with_index do |item, index|
      item_description = yield(item)
      puts "#{index + 1}. #{item_description}"
    end
    index = gets.to_i - 1
    collection[index]
  end
  
  def select_route
    select_from_collection(@routes, 'Выберите маршрут:') do |route|
      "#{route.start_station.name} – #{route.end_station.name}"
    end
  end
  
  def select_train
    select_from_collection(@trains, 'Выберите поезд:') do |train|
      train.number
    end
  end
end
