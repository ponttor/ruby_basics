# frozen_string_literal: true

require_relative './deck'
require_relative './hand'
require_relative './player'
require_relative './dealer'
require_relative './card_dealer'
require_relative './round_manager'
require_relative '../services/interface_service'

class Game
  attr_reader :player, :dealer, :deck, :round_manager, :card_dealer

  def initialize(player_name)
    @player = Player.new(player_name)
    @dealer = Dealer.new
    @deck = Deck.new
    @round_manager = RoundManager.new(@player, @dealer, @deck)
    @card_dealer = CardDealer.new(@deck)
  end

  def setup_game
    player.hand = Hand.new
    dealer.hand = Hand.new

    card_dealer.deal_cards_to(player, dealer)

    player.make_bet(10)
    dealer.make_bet(10)
  end

  def play_round
    InterfaceService.display_current_hands(player, dealer)
    round_manager.manage_game_flow
  end
end
