# Step 1: User makes a choice
# Step 2: Computer makes a choice
# Step 3: Winner is displayed
#
# Rock, Paper, Scissors is a two-player game where each player chooses
# one of three possible moves: rock, paper, or scissors. The chosen moves
# will then be compared to see who wins, according to the following rules:
#
# - rock beats scissors
# - scissors beats paper
# - paper beats rock
#
# If the players chose the same move, then it's a tie.
#
# Extract Nouns and Verbs:
# Nouns: player, move, rule
# Verbs: choose, compare

require 'pry'
module Message
  def print_choices(values)
    print "Please choose "
    values.each_with_index do |val, i|
      if i == values.size - 1
        puts "or #{val}:"
      else
        print "#{val}, "
      end
    end
  end

  def get_values(values)
    return_str = ""
    values.each_with_index do |val, i|
      if i == values.size - 1
        return_str += "#{val.capitalize}"
      else
        return_str += "#{val.capitalize}, "
      end
    end
    return_str
  end
end

class Player
  include Message
  # @@move_history = {}
  attr_accessor :move, :name
  attr_reader :move_history, :score

  def initialize(player_type = :human)
    @player_type = player_type
    set_name
    @move_history = {0 => nil}
    @score = 0
    # @@move_history[0] = nil
  end

  def human?
    @player_type == :human
  end

  protected
  attr_writer :score
end

class Human < Player
  # def initialize(player_type)
  # #   @@move_history[0] = nil
  #   @move_history = {0 => nil}
  #   @score = 0
  #   super
  # end

  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  # def self.record_game
  #   @@move_history[@@move_history.keys.max + 1] = self.move
  # end

  def choose
    choice = nil
    loop do
      print_choices(Move.values)
      choice = gets.chomp
      break if Move.values.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
    # record_game
    @move_history[@move_history.keys.max + 1] = self.move
  end
  # def move_history
  #   @move_history
  # end
end

class Computer < Player
  # @@move_history = {0 => nil}
  # def initialize(player_type)
  # #   @@move_history[0] = nil
  # #   super()
  # end
  NAMES = ['Hal', 'R2D2', 'Chappie', 'Sonny', 'Number 5']
  # def initialize(player_type = :computer)
  #   @player_type = player_type
  #   super(@player_type)
  # end

  def set_name
    # self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
    # @names = {'Hal' => Hal.new, 'R2D2' => R2D2.new, 'Chappie' => Chappie.new, 'Sonny' => Sonny.new, 'Number 5' => Number5.new}
    @names = {'Hal' => Hal, 'R2D2' => R2D2, 'Chappie' => Chappie, 'Sonny' => Sonny, 'Number 5' => Number5}

    @name_choice = NAMES.sample

    # self.name = @names[NAMES.sample].new
    self.name = @names[@name_choice]

  end

  def choose
    # self.move = Move.new(Move::VALUES.keys.sample)
    self.move = Move.new(Move.values.sample)
    # record_game
    @move_history[@move_history.keys.max + 1] = self.move

  end
  # def self.record_game
  #   @@move_history[@@move_history.keys.max + 1] = self.move
  # end
  # def move_history
  #   @@move_history
  # end
end

class Hal < Computer
  def to_s
    'Hal'
  end
end

class R2D2 < Computer
  def to_s
    'R2D2'
  end
end

class Chappie < Computer
  def to_s
    'Chappie'
  end
end

class Sonny < Computer
  def to_s
    'Sonny'
  end
end

class Number5 < Computer
  def to_s
    'Number 5'
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors']
  attr_reader :value

  def initialize(value)
    # @possible_values = { 'rock' => Rock.new,
    #                      'paper' => Paper.new,
    #                      'scissors' => Scissors.new }

    # @value = @possible_values[value]
    @value = value
  end

  def self.values
    VALUES
  end

  def >(other_move)
    # VALUES[other_move].weakness == @value
    other_move.value.weakness == @value.to_s

  end

  def <(other_move)
    # VALUES[@value].weakness == other_move
    @value.weakness == other_move.value.to_s
    # VALUES[other_move] == @value
  end
  def sign
    case @value
    when rock?

    when paper?

    when scissors?

    when lizard?

    when spock?

    end
  end
  def paper?(val)
    val == 'paper'
  end
  def scissors?(val)
    val == 'scissors'
  end
  def rock?(val)
    val == 'rock'
  end
  def lizard?(val)
    val == 'lizard'
  end
  def spock?(val)
    val == 'spock'
  end

  def to_s
    @value.to_s
  end
end

class Sign
  VERBS = {'rock' => {'scissors' => 'crushes', 'lizard' => 'crushes'},
           'paper' => {'rock' => 'covers', 'spock' => 'disproves'},
           'scissors' => {'paper' => 'cuts', 'lizard' => 'decapitates'},
           'lizard' => {'spock' => 'poisons', 'paper' => 'eats'},
           'spock' => {'rock' => 'vaporizes', 'scissors' => 'smashes'}}

  def initialize
    @sign = nil
  end

  def win_msg(other_move)
    "#{self} #{@verb} #{other_move.value}"
  end

  def weakness
    VERBS.select do |s, v|
      v.keys.include?(@sign)
    end.keys
  end

  def to_s
    @sign
  end
end

class Paper < Sign
  def initialize
    @sign = 'paper'
  end
end

class Scissors < Sign
  def initialize
    @sign = 'scissors'
  end
end

class Rock < Sign
  def initialize
    @sign = 'rock'
  end
end

class Lizard < Sign
  def initialize
    @sign = 'lizard'
  end
end

class Spock < Sign
  def initialize
    @sign = 'spock'
  end
end

class RPSGame
  include Message
  attr_accessor :human, :computer

  def initialize
    @human = Human.new(:human)
    @computer = Computer.new(:computer)
  end

  def display_welcome_message
    print "Welcome to #{get_values(Move.values)}!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing #{get_values(Move.values)}. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.move.value.win_msg(computer.move)} "
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.move.value.win_msg(human.move)} "
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
    end

    return true if answer.downcase == 'y'
    return false if answer.downcase == 'n'
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end
    # binding.pry
    display_goodbye_message
  end
end

RPSGame.new.play








# class Person
#   attr_accessor :name
#   def initialize(name)
#     hsh = {'dave' => Dave, 'susan' => Susan}
#     @name = hsh[name].new
#   end
# end
#
# class Dave
#   def to_s
#     'dave'
#   end
# end
#
# class Susan
#   def to_s
#     'susan'
#   end
# end
#
# david = Person.new('dave')
# p david
