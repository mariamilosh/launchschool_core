class GuessingGame
  # NUM_RANGE = 1..100
  # GUESS_LIMIT = 7

  def initialize(low, high)
    @num_range = Range.new(low, high)
    @guess_limit = Math.log2(@num_range.size).to_i + 1
  end

  def play
    choose_num
    @guess_limit.downto(1) do |c|
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
      print "Enter a number between #{@num_range.min} and #{@num_range.max}: "
      guess = gets.chomp
      return guess.to_i unless !in_range?(guess.to_i)
      print "Invalid guess. "
    end
  end

  def in_range?(num)
    @num_range === num
  end

  def check_guess(guess)
    guess <=> @secret_num
  end

  def choose_num
    prng = Random.new
    @secret_num = prng.rand(@num_range)
  end
end

game = GuessingGame.new(1, 200)
game.play
