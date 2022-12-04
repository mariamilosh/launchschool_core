password = nil

def set_password
  puts 'What would you like your password to be?'
  new_password = gets.chomp
  new_password  # password is local variable within method
end

def verify_password(password)
  puts '** Login **'
  print 'Password: '
  input = gets.chomp

  if input == password  # cannot reference variable from outside method
    puts 'Welcome to the inside!'
  else
    puts 'Authentication failed.'
  end
end

if !password
  password = set_password
end

verify_password(password)
