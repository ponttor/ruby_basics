# frozen_string_literal: true

class ScoreService
  BLACKJACK = 21

  def self.evaluate_winner(player, dealer, bet_amount)
    player_score = player.hand.score
    dealer_score = dealer.hand.score

    if player_score > BLACKJACK
      player_busts(player, dealer, bet_amount)
    elsif dealer_score > BLACKJACK || player_score > dealer_score
      player_wins(player, dealer, bet_amount)
    elsif player_score == dealer_score
      tie_game(player, dealer, bet_amount)
    else
      dealer_wins(player, dealer, bet_amount)
    end
  end

  def self.player_busts(player, dealer, bet_amount)
    puts "Player busts with #{player.hand.score}! Dealer wins."
    dealer.balance += bet_amount * 2
  end

  def self.player_wins(player, _dealer, bet_amount)
    puts "Player wins with #{player.hand.score}!"
    player.balance += bet_amount * 2
  end

  def self.tie_game(player, dealer, bet_amount)
    puts "It's a tie at #{player.hand.score}!"
    player.balance += bet_amount
    dealer.balance += bet_amount
  end

  def self.dealer_wins(_player, dealer, bet_amount)
    puts "Dealer wins with #{dealer.hand.score}!"
    dealer.balance += bet_amount * 2
  end
end
