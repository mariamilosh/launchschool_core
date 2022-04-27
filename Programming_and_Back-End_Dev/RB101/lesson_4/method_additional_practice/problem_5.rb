flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

#flintstones.select {|name| name[0,2] == "Be"}

p flintstones.index { |name| name[0, 2] == "Be" }
