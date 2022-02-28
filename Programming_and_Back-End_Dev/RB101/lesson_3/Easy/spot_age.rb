ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

p ages.key?("Spot")

p ages.any? {|key, val| key == "Spot"}

p ages.has_key?("Spot")

# ages.include?("Spot")
# ages.member?("Spot")
