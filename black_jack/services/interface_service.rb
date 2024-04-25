# frozen_string_literal: true

class InterfaceService
  class << self
    def get_user_input(prompt)
      print prompt
      gets.chomp
    end

    def reveal_cards(player, dealer)
      puts "Player's hand: #{display_hand(player)}"
      puts "Dealer's hand: #{display_hand(dealer)}"
    end

    def get_player_choice
      puts "Choose 'hit' to take another card, 'stand' to hold your hand, or 'reveal' to show all cards and finish the round."
      gets.chomp.downcase
    end

    def display_current_hands(player, dealer)
      puts "Your hand: #{display_hand(player)}"
      puts "Dealer's hand: #{'** ' * dealer.hand.cards.count}"
    end

    def display_hand(player)
      player.hand.cards.map { |card| "#{card.rank}#{card.suit}" }.join(' ')
    end

    def display_balances(player, dealer)
      puts "Player's balance: $#{player.balance}"
      puts "Dealer's balance: $#{dealer.balance}"
    end
  end
end
