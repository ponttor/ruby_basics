# frozen_string_literal: true

require_relative 'player'

class CardDealer
  attr_reader :deck

  def initialize(deck)
    @deck = deck
  end

  def deal_cards_to(player, dealer)
    deck.shuffle

    2.times { player.hand.add_card(deck.deal_card) }
    2.times { dealer.hand.add_card(deck.deal_card) }
  end
end
