# def shout?(name)
#   # if name.slice(-1) == '!'
#   #   name.slice!(-1)
#   #   true
#   # else
#   #   false
#   # end
#
#   name.chomp!('!')
# end

def shout?(name)
  name.chomp!('!')
end

print "What is your name? "
name = gets.chomp

if shout?(name)
  puts "HELLO #{name.upcase}. WHY ARE WE SCREAMING?"
else
  puts "Hello #{name}."
end
