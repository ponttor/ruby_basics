puts 'Enter day number'
day = gets.chomp.to_i

puts 'Enter month number'
month = gets.chomp.to_i

puts 'Enter year number'
year = gets.chomp.to_i

def leap_year?(year)
  (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)
end

def calculate_ordinal_date(day, month, year)
  days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  days_in_months[1] = 29 if leap_year?(year)

  days_before_month = days_in_months.take(month - 1).sum
  days_before_month + day
end

result = calculate_ordinal_date(day, month, year)
