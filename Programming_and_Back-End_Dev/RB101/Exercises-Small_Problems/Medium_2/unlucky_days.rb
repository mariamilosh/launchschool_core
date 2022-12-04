def friday_13th(year)
  day = 13
  months = (1..12)
  count = 0
  months.each do |month|
    count += 1 if Time.new(year, month, day).friday?
  end
  count
end

puts friday_13th(2015) == 3
puts friday_13th(1986) == 1
puts friday_13th(2019) == 2
