flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

barney = flintstones.select { |key, value| key == "Barney"}
barney = barney.to_a.flatten
p barney

#flintstones.assoc("Barney")
