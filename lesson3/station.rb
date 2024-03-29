class Station
  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    @trains << train
  end

  def trains_names
    @trains.map(&:name)
  end

  def trains_by_type(type)
    @trains.count { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end
