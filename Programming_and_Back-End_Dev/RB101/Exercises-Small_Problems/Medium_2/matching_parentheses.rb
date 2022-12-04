# ( open ( open   close ) close )
# must not allow close parenthesis before there is an open
# must have a close parenthesis for every open
# count parenthesis
# add open subtract close
# must never be negative
# must end equal to zero

# def balanced?(str)
#   # parens = { '(' => 0, ')' => 0, '[' => 0, ']' => 0, '{' => 0, '}' => 0 }
#   count = 0
#   str.chars.each do |chr|
#     count += 1 if chr == '('
#     count -= 1 if chr == ')'
#     return false if count < 0
#   end
#   count == 0
#   # str.chars.each do |chr|
#   #   if chr == '(' || chr == '[' || chr == '{'
#   #     parens[chr] += 1
#   #   elsif chr == ')' || chr == ']' || chr == '}'
#   #     parens[chr] -= 1
#   #     return false if parens[chr] < 0
#   #   end
#   # end
# end

# chain
# must finish with current bracket set or open new one
def balanced?(str)
  prev_brackets = []
  pairs = { '(' => ')', '[' => ']', '{' => '}' }
  str.chars.each do |chr|
    if chr == '(' || chr == '[' || chr == '{'
      prev_brackets.push(chr)
    elsif chr == ')' || chr == ']' || chr == '}'
      return false if pairs[prev_brackets.pop] != chr
    end
  end
  prev_brackets.empty?
end

puts balanced?('What (is) this?') == true
puts balanced?('What is) this?') == false
puts balanced?('What (is this?') == false
puts balanced?('((What) (is this))?') == true
puts balanced?('((What)) (is this))?') == false
puts balanced?('Hey!') == true
puts balanced?(')Hey!(') == false
puts balanced?('What ((is))) up(') == false
puts balanced?('What {(is)} [u]p') == true
puts balanced?('(([What)] (is this))?') == false
