def spin_me(str)
  str.split.each do |word|
    word.reverse!
  end.join(" ")
end

str = "hello world"
puts spin_me(str) # "olleh dlrow"
puts str

# They are different objects because actions are performed after the string
#   has been converted into an array
