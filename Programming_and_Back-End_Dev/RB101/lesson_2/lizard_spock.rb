MAX_WINS = 3
CHOICES = {
  rock: ['scissors', 'lizard'],
  paper: ['rock', 'spock'],
  scissors: ['paper', 'lizard'],
  lizard: ['paper', 'spock'],
  spock: ['rock', 'scissors']
}
WELCOME_MESSAGE = <<-MSG
************************************************
*-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~*
*-~-* Rock, Paper, Scissors, Lizard, Spock *~-~*
*-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~*
************************************************
You will play against the computer
The first to 3 points wins!

Rules:
Scissors cuts Paper covers Rock crushes
Lizard poisons Spock smashes Scissors
decapitates Lizard eats Paper disproves
Spock vaporizes Rock crushes Scissors

MSG
score = { player: 0, computer: 0 }

def prompt(message)
  puts("=> #{message}")
end

def get_choices
  valid_choices = []
  CHOICES.each_key { |key| valid_choices << key.to_s }
  valid_choices
end

def get_player_choice
  choice = ''
  valid = nil
  loop do
    prompt("Choose one: #{get_choices.join(', ')}")
    choice = gets.chomp.downcase

    loop do
      break if choice != "s"
      prompt("Do you mean scissors or spock?")
      choice = gets.chomp.downcase
      prompt("You gotta give me more than that, champ.") if choice == "s"
    end

    CHOICES.keys.each do |val|
      if val.to_s[0, (choice.size)] == choice
        choice = val.to_s
        valid = true
      end
    end

    if valid
      break
    else
      prompt("That is not a valid choice.")
    end
  end
  choice
end

def win?(first, second)
  true if CHOICES.dig(first.to_sym).include?(second)
end

def display_result(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif player == computer
    prompt("It's a tie!")
  else
    prompt("You lose")
  end
end

def play_again?
  loop do
    prompt("Do you want to play again? (y/n)")
    answer = gets.chomp.downcase
    if "yes"[0, answer.size] == answer
      return true
    elsif "no"[0, answer.size] == answer
      return false
    else
      prompt("That is not a valid response.")
    end
  end
end

def update_score!(player, computer, score)
  if win?(player, computer)
    score[:player] += 1
  elsif win?(computer, player)
    score[:computer] += 1
  end
end

def winner_message(score)
  if score[:player] > score[:computer]
    prompt("You are the grand winner!")
  elsif score[:player] < score[:computer]
    prompt("The computer is the grand winner.")
  end
end

def winner?(score)
  score.value?(MAX_WINS)
end

def get_score(score)
  prompt("")
  prompt("***Score***")
  prompt("You: #{score[:player]}")
  prompt("Computer: #{score[:computer]}")
  prompt("***********")
  prompt("")
end

def reset_score!(score)
  score[:player] = 0
  score[:computer] = 0
end

loop do
  reset_score!(score)
  system 'clear'
  puts WELCOME_MESSAGE
  loop do
    player_choice = get_player_choice
    computer_choice = get_choices.sample
    sleep(0.1)
    system 'clear'
    puts WELCOME_MESSAGE
    prompt("You chose: #{player_choice}; Computer chose: #{computer_choice}")
    display_result(player_choice, computer_choice)
    update_score!(player_choice, computer_choice, score)
    get_score(score)
    break if winner?(score)
  end

  winner_message(score)
  break unless play_again?
end

prompt("Thank you for playing. Good bye!")
