def center_of(text)
  text.slice((text.size - 1) / 2, (text.size + 1) % 2 + 1)
end

center_of('I love Ruby') == 'e'
center_of('Launch School') == ' '
center_of('Launch') == 'un'
center_of('Launchschool') == 'hs'
center_of('x') == 'x'