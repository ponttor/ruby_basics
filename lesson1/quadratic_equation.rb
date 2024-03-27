puts 'Please enter coefficient a'
a = gets.chomp.to_f

puts 'Please enter coefficient b'
b = gets.chomp.to_f

puts 'Please enter coefficient c'
c = gets.chomp.to_f

d = b ** 2 - 4 * a * c

if d.positive?
  puts "#{(- b - Math.sqrt(d)) / (2.0 * a)}"
  puts "#{(- b + Math.sqrt(d)) / (2.0 * a)}"
elsif d.zero?
  puts d
  puts "#{(- b / (2.0 * a))}"
else
  puts 'No roots'
end