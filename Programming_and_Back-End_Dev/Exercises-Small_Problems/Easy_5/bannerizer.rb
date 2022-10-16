def print_in_box(str)
  width = str.length
  print '+-'
  width.times { print '-' }
  print '-+'
  puts ""
  print "| "
  width.times { print ' ' }
  puts " |"
  puts "| " + str + " |"
  print "| "
  width.times { print ' ' }
  puts " |"
  print '+-'
  width.times { print '-' }
  puts '-+'
end

print_in_box('To boldly go where no one has gone before.')
print_in_box('')


def print_in_box(message)
   horizontal_rule = "+#{'-' * (message.size + 2)}+"
   empty_line = "|#{' ' * (message.size + 2)}|"

   puts horizontal_rule
   puts empty_line
   puts "| #{message} |"
   puts empty_line
   puts horizontal_rule
end
