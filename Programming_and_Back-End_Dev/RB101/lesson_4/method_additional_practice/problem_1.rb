flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
flintstones_h = Hash.new

flintstones.each_with_index do |val, key|
  flintstones_h[key] = val
end

p flintstones_h
