def after_midnight(time_str)
  hrs_mins = time_str.split(':').map { |t| t.to_i }
  (hrs_mins[0] % 24) * 60 + hrs_mins[1]
end

def before_midnight(time_str)
  (24 * 60 - after_midnight(time_str)) % (24 * 60)
end

puts after_midnight('00:00') == 0
puts before_midnight('00:00') == 0
puts after_midnight('12:34') == 754
puts before_midnight('12:34') == 686
puts after_midnight('24:00') == 0
puts before_midnight('24:00') == 0
