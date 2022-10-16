# def swap(str)
#   str.split(' ').map do |word|
#     new_str = ''
#     if !word.empty?
#       new_str = new_str +  word.slice!(-1)
#     end
#     if word != ''
#       new_str = new_str + word.slice!(1..-1)
#     end
#     if word != ''
#       new_str = new_str + word.slice(0)
#     end
#     new_str
#   end.join(' ')
# end

def swap(str)
  str_swap = ''
  str.scan(/(\w?)(\w+?)(\w?)(\s?)\b/) { |x, y, z, s| str_swap << (z + y + x + s) }
  str_swap
end

puts swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
puts swap('Abcde') == 'ebcdA'
puts swap('a') == 'a'
