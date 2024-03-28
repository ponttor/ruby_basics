cart = {}
total_sum = 0

loop do
  puts 'Enter product name or "stop" to finish:'
  product = gets.chomp
  break if product == "stop"

  puts 'Enter price per unit:'
  price = gets.chomp.to_f

  puts 'Enter amount:'
  amount = gets.chomp.to_f

  cart[product] = {price: price, amount: amount}
  cart[product][:total] = price * amount
  total_sum += cart[product][:total]
end

cart.each do |product, info|
  puts "Total for #{product}: #{info[:total]}"
end
puts "Total sum of purchases: #{total_sum}"
