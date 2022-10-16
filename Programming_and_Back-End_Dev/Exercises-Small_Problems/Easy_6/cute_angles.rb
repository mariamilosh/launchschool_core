DEGREE = "\xC2\xB0"

def dms(angle)
  # degrees = angle.truncate
  # minutes = calculate_time(angle)
  # seconds = calculate_time(minutes)
  degrees = angle.truncate
  minutes = (angle - degrees) * 60
  seconds = (minutes - minutes.truncate) * 60
  deg_str = degrees.to_s + DEGREE
  min_str = time_str(minutes, "\'")
  sec_str = time_str(seconds, "\"")
  "#{deg_str}#{min_str}#{sec_str}"
end
#
# def calculate_time(num)
#   (num % 1) * 60
# end

def time_str(num, ch)
  "%02d" % num + ch
end

puts dms(30) == %(30°00'00")
puts dms(76.73) == %(76°43'48")
puts dms(254.6)
# == %(254°36'00")
puts dms(93.034773) == %(93°02'05")
puts dms(0) == %(0°00'00")
puts dms(360) == %(360°00'00") || dms(360) == %(0°00'00")
