puts 'Please enter your name'
name = gets.chomp

puts 'Please enter your height'
height = gets.chomp.to_f

optimal_weight = (height - 110) * 1.15

if optimal_weight.negative?
  puts "Dear #{name}, your weight is optimal, congrats!"
else
  puts "Dear #{name}, your optimal weight is #{optimal_weight}"
end
