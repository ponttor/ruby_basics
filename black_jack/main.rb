# frozen_string_literal: true

require_relative './models/game'
require_relative './services/interface_service'

begin
  player_name = InterfaceService.get_user_input('Enter your name:')
  game = Game.new(player_name)
rescue StandardError => e
  puts "Error: #{e.message}"
  retry
end

loop do
  game.setup_game
  game.play_round

  continue = InterfaceService.get_user_input("Let's play again? (yes/no): ")
  break if continue.downcase == 'no'
end

puts 'Goodbye!'
