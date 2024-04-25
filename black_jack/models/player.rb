# frozen_string_literal: true

require_relative '../services/validation'

class Player
  include Validation

  validate :name, :presence
  validate :name, :type, String

  attr_reader :name
  attr_accessor :hand, :balance

  def initialize(name)
    @name = name
    validate!
    @balance = 100
  end

  def make_bet(amount)
    self.balance -= amount
  end
end
