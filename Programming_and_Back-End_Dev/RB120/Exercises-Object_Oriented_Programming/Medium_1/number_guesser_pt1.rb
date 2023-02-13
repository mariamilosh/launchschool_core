class GuessingGame
  NUM_RANGE = 1..100
  GUESS_LIMIT = 7

  def play
    choose_num
    GUESS_LIMIT.downto(1) do |c|
      if c == 1
        puts "You have #{c} guess remaining."
      else
        puts "You have #{c} guesses remaining."
      end
      guess = get_guess
      case check_guess(guess)
      when -1
        puts "Your guess is too low."
      when 1
        puts "Your guess is too high."
      when 0
        puts "That's the number!"
        puts ""
        puts "You won!"
        puts ""
        return
      end
      puts ""
    end
    puts "You have no more guesses. You lost!"
    puts ""
  end

  private

  def get_guess
    loop do
      print "Enter a number between #{NUM_RANGE.min} and #{NUM_RANGE.max}: "
      guess = gets.chomp
      return guess.to_i unless !in_range?(guess.to_i)
      print "Invalid guess. "
    end
  end

  def in_range?(num)
    NUM_RANGE === num
  end

  def check_guess(guess)
    guess <=> @secret_num
  end

  def choose_num
    prng = Random.new
    @secret_num = prng.rand(NUM_RANGE)
  end
end

game = GuessingGame.new
game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.
#
# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.
#
# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.
#
# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80
#
# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!
#
# You won!

game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.
#
# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.
#
# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.
#
# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.
#
# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.
#
# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.
#
# You have 1 guess remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.
#
# You have no more guesses. You lost!
