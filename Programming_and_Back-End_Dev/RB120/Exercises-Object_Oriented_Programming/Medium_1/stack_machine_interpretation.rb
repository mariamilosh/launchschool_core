require 'set'

class MinilangError < StandardError; end
class BadTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang]
  COMMANDS = ['PUSH', 'ADD', 'SUB', 'MULT', 'DIV', 'MOD', 'POP', 'PRINT']

  def initialize(commands)
    @commands = commands
    @stack = []
    @register = 0
  end

  def eval
    @commands.split.each do |command|
      if COMMANDS.include?(command)
        send(command.downcase)
      elsif command == command.to_i.to_s
        n(command.to_i)
      else
        raise BadTokenError, "Invalid token: #{command}"
      end
    rescue NoMethodError
      puts "ERROR: empty stack (NoMethodError)"
    rescue TypeError
      puts "ERROR: empty stack (TypeError)"
    rescue ZeroDivisionError
      puts "ERROR: divided by zero (ZeroDivisionError)"
    end
  end

  def n(val)
    @register = val
  end

  def push
    @stack << @register
  end

  def add
    tmp_val = pop + @register
    @register = tmpVal
    # @register += pop
  end

  def sub
    @register -= pop
  end

  def mult
    @register *= pop
  end

  def div
    @register /= pop
  end

  def mod
    @register %= pop
  end

  def pop
    raise EmptyStackError, "Empty stack!" if @stack.empty?
    @register = @stack.pop
  end

  def print
    puts "#{@register}"
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

# Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

# Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
