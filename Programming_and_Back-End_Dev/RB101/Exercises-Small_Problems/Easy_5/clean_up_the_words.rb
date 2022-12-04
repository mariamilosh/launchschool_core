def cleanup(str)
  str.gsub!(/\W+/, " ")
end

puts cleanup("---what's my +*& line?") == ' what s my line '
