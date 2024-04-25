# frozen_string_literal: true

require_relative '../services/validation'

class Card
  include Validation

  ACE_LOW_VALUE = 1
  ACE_HIGH_VALUE = 11
  FACE_CARD_VALUE = 10

  VALID_SUITS = ['+', '<3', '^', '<>'].freeze
  VALID_RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  validate :rank, :inclusion, VALID_RANKS
  validate :suit, :inclusion, VALID_SUITS

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    validate!
  end

  def value
    return FACE_CARD_VALUE if %w[J Q K].include?(rank)
    return [ACE_LOW_VALUE, ACE_HIGH_VALUE] if is_ace?

    rank.to_i
  end

  def is_ace?
    rank == 'A'
  end
end
