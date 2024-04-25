# frozen_string_literal: true

require_relative './card'
require_relative '../services/score_service'

class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def add_card(card)
    cards << card
  end

  def score
    total, aces = initial_score_and_aces_count
    adjust_score_for_aces(total, aces)
  end

  private

  def initial_score_and_aces_count
    total = 0
    aces = 0

    cards.each { |card| total, aces = add_card_score(card, total, aces) }

    [total, aces]
  end

  def add_card_score(card, total, aces)
    if card.is_ace?
      aces += 1
      total += Card::ACE_HIGH_VALUE
    else
      total += card.value
    end
    [total, aces]
  end

  def adjust_score_for_aces(total, aces)
    while total > ScoreService::BLACKJACK && aces.positive?
      total -= 10
      aces -= 1
    end

    total
  end
end
