require 'date'

def get_days_in_month(month, year=2024)
  Date.new(year, month, -1).day
end

months_days = (1..12).each_with_object({}) do |month, hash|
  month_name = Date::MONTHNAMES[month]
  days = get_days_in_month(month)

  hash[month_name] = days
  puts month_name if days == 30
end
