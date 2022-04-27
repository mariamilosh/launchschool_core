[1, 2, 3].select do |num|
  num > 5
  'hi'
end

# returns an array with [1, 2, 3] because it evaluates the truthiness of 'hi'
# rather than num > 5 because it's last
