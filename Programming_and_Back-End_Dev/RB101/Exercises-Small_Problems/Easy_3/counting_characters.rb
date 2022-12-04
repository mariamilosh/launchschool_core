print "Please write word or multiple words: "
words = gets.chomp
words_no_spaces = words.split(" ").join("")
puts "There are #{words_no_spaces.length} characters in \"#{words}\"."
