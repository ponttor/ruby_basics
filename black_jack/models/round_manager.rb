# frozen_string_literal: true

require_relative '../services/interface_service'
require_relative '../services/score_service'

class RoundManager
  attr_reader :player, :dealer, :deck

  MAX_CARDS_COUNT = 3
  MIN_DEALER_SCORE = 17
  STANDARD_BET_AMOUNT = 10

  def initialize(player, dealer, deck)
    @player = player
    @dealer = dealer
    @deck = deck
  end

  def manage_game_flow
    loop do
      user_input = InterfaceService.get_player_choice
      handle_player_choice(user_input)

      break if round_over? || user_input == 'reveal'

      next unless dealer_turn_needed?

      handle_dealer_turn
      break if round_over?

      InterfaceService.display_current_hands(player, dealer)
    end
  end

  private

  def handle_player_choice(choice)
    case choice
    when 'hit'
      handle_hit
    when 'reveal'
      conclude_round
    when 'stand'
      handle_stand
    else
      raise 'Invalid choice'
    end
  end

  def dealer_turn_needed?
    dealer.hand.cards.count < MAX_CARDS_COUNT
  end

  def conclude_round
    InterfaceService.reveal_cards(player, dealer) unless @reveal_triggered
    ScoreService.evaluate_winner(player, dealer, STANDARD_BET_AMOUNT)
    InterfaceService.display_balances(player, dealer)
  end

  def handle_dealer_turn
    if should_dealer_hit?
      add_card_to_hand(dealer)
    else
      puts 'Dealer stands'
    end
    conclude_round if round_over?
  end

  def handle_hit
    if can_hit?(player)
      add_card_to_hand(player)
      InterfaceService.display_current_hands(player, dealer)
    else
      puts 'You cannot hit, you already have 3 cards.'
    end
    conclude_round_if_needed if round_over?
  end

  def handle_stand
    puts 'You stand'
  end

  def should_dealer_hit?
    dealer.hand.score < MIN_DEALER_SCORE && dealer.hand.cards.count < MAX_CARDS_COUNT
  end

  def add_card_to_hand(participant)
    participant.hand.add_card(deck.deal_card)
    puts "#{participant.class} chose to hit."
  end

  def round_over?
    player.hand.cards.count == MAX_CARDS_COUNT && dealer.hand.cards.count == MAX_CARDS_COUNT
  end

  def can_hit?(participant)
    participant.hand.cards.count < MAX_CARDS_COUNT
  end
end
