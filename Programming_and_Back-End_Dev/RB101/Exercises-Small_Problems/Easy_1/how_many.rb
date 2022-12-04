vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]

def count_occurrences(vehicles)
  vehicles_hsh = {}
  vehicles.each do |vehicle|
    if vehicles_hsh.key?(vehicle)
      vehicles_hsh[vehicle] += 1
    else
      vehicles_hsh[vehicle] = 1
    end
  end
  vehicles_hsh.each { |k, v| puts "#{k} => #{v}"}
end

count_occurrences(vehicles)
