def count_occurrences(arr)
  case_insensitive_arr = arr.map(&:downcase)
  uniq_elements = case_insensitive_arr.uniq
  uniq_elements.each { |el| puts "#{el} => #{case_insensitive_arr.count(el)}" }
end

vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]

count_occurrences(vehicles)

