# frozen_string_literal: true

require_relative './card'

class Deck
  def initialize
    @cards = Card::VALID_SUITS.product(Card::VALID_RANKS).map { |suit, rank| Card.new(rank, suit) }
  end

  def shuffle
    @cards.shuffle!
  end

  def deal_card
    @cards.pop
  end
end
