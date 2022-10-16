NUM_ENDINGS = { 0 => 'th', 1 => 'st', 2 => 'nd', 3 => 'rd', 4 => 'th',
                5 => 'th', 6 => 'th', 7 => 'th', 8 => 'th', 9 => 'th' }

def century(year)
  cen = (year.to_f / 100).ceil
  if (10..20).include?(cen.to_s.slice(-2, 2).to_i)
    suffix = 'th'
  else
    suffix = NUM_ENDINGS[cen.to_s.slice(-1).to_i]
  end
  cen.to_s + suffix
end

puts century(2000) == '20th'
puts century(2001) == '21st'
puts century(1965) == '20th'
puts century(256) == '3rd'
puts century(5) == '1st'
puts century(10103) == '102nd'
puts century(1052) == '11th'
puts century(1127) == '12th'
puts century(11201) == '113th'
