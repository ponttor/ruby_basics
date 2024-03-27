puts 'Please enter the length of the first side of triangle'
side_a = gets.chomp.to_f

puts 'Please enter the length of the second side of triangle'
side_b = gets.chomp.to_f

puts 'Please enter the length of the thir side of triangle'
side_c = gets.chomp.to_f

a, b, c = [side_a, side_b, side_c].sort

is_equilateral = a == c
is_right = c ** 2 == a ** 2 + b ** 2
is_isosceles =  a == b || b == c

if is_equilateral
  puts 'the triangle is a equilateral triangle'
elsif is_right && is_isosceles
  puts 'the triangle is an equilateral and isosceles triangle'
elsif is_right
  puts 'the triangle is a right triangle'
elsif is_isosceles
  puts 'the triangle is an isosceles triangle'
else
  puts 'this is a regular triangle'
end