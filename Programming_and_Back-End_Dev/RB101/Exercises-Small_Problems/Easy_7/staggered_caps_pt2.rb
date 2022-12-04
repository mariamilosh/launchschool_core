def staggered_case(str)
  up = true
  str.chars.map do |ch|
    if up && (ch ~= /[a-zA-Z]/)
      up = false
      ch.upcase
    elsif ch ~= /[a-zA-Z]/
      up = true
      ch.downcase
    else
      ch
    end
  end.join
end

puts staggered_case('I Love Launch School!') == 'I lOvE lAuNcH sChOoL!'
puts staggered_case('ALL CAPS') == 'AlL cApS'
puts staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 nUmBeRs'
