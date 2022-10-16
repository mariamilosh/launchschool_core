def switch_lights(n)
  lights = []
  (1..n).each do |i|
    lights += (1..n).select { |d| d % i == 0}
  end
  lights.select { |light| lights.count(light).odd? }.uniq
end

puts "#{switch_lights(5)}"
puts "#{switch_lights(10)}"
puts "#{switch_lights(1000)}"
