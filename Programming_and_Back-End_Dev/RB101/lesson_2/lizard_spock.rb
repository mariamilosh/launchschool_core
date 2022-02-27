VALID_CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
BEATS = {
  rock: ['scissors', 'lizard'],
  paper: ['rock', 'spock'],
  scissors: ['paper', 'lizard'],
  lizard: ['paper', 'spock'],
  spock: ['rock', 'scissors']
}
$player_score = 0
$computer_score = 0

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  true if BEATS.dig(first.to_sym).include?(second)
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

def update_score!(player, computer)
  if win?(player, computer)
    $player_score += 1
  elsif player == computer
    $player_score += 1
    $computer_score += 1
  else
    $computer_score += 1
  end
end

def winner_message
  if $player_score >= 3 && $computer_score < 3
    prompt("You are the grand winner!")
  elsif $computer_score == 3 && $player_score == 3
    prompt("You tied for grand winner.")
  else
    prompt("The computer is the grand winner.")
  end
end

def winner?
  ($player_score >= 3 && $computer_score < 3) ||
    ($computer_score >= 3 && $player_score < 3) ||
    ($computer_score == 3 && $player_score == 3)
end

def score
  prompt("***Score***")
  prompt("You: #{$player_score}")
  prompt("Computer: #{$computer_score}")
  prompt("***********")
end

def reset_score!
  $player_score = 0
  $computer_score = 0
end

loop do
  reset_score!
  loop do
    choice = ''
    valid = nil
    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      choice = Kernel.gets().chomp().downcase()

      # if VALID_CHOICES.include?(choice) || VALID_CHOICES.include?(choice)
      #   break
      # else
      #   prompt("That is not a valid choice.")
      # end

      loop do
        break if choice != "s"
        prompt("Do you mean scissors or spock?")
        choice = Kernel.gets().chomp().downcase()
        prompt("You gotta give me more than that, champ.") if choice == "s"
      end

      VALID_CHOICES.each do |val|
        if val[0, (choice.size)] == choice
          choice = val
          valid = true
        end
      end

      if valid
        break
      else
        prompt("That is not a valid choice.")
      end
    end

    computer_choice = VALID_CHOICES.sample

    prompt("You chose: #{choice}; Computer chose: #{computer_choice}")
    display_result(choice, computer_choice)
    update_score!(choice, computer_choice)
    score()
    break if winner?()
  end
  winner_message()
  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for playing. Good bye!")
