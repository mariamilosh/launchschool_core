def print_madlib(hsh)
  puts "Do you #{hsh['verb']} your #{hsh['adj']} #{hsh['noun']} #{hsh['adverb']}? That's hilarious!"
end

def choices
  words = {}
  print "Enter a noun: "
  words['noun'] = gets.chomp
  print "Enter a verb: "
  words['verb'] = gets.chomp
  print "Enter an adjective: "
  words['adj'] = gets.chomp
  print "Enter an adverb: "
  words['adverb'] = gets.chomp
  words
end

print_madlib(choices)
