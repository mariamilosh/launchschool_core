def time_of_day(mins)
  mins.negative? ? subtract_minutes(mins.abs) : add_minutes(mins)
end

def subtract_minutes(mins)
  hrs_and_mins = (60 * 24 - mins).divmod(60)
  format_time(hrs_and_mins)
end

def add_minutes(mins)
  hrs_and_mins = mins.divmod(60)
  format_time(hrs_and_mins)
end

def format_time(hrs_and_mins)
  (hrs_and_mins[0] % 24).to_s.rjust(2, '0') + \
    ':' + hrs_and_mins[1].to_s.rjust(2, '0')
end

puts time_of_day(0) == "00:00"
puts time_of_day(-3) == "23:57"
puts time_of_day(35) == "00:35"
puts time_of_day(-1437) == "00:03"
puts time_of_day(3000) == "02:00"
puts time_of_day(800) == "13:20"
puts time_of_day(-4231) == "01:29"
