# def minilang(str_commands)
#   commands = str_commands.split(" ")
#   reg = 0
#   stack = []
#   commands.each do |c|
#     case c
#     when 'PUSH'
#       stack.push(reg)
#     when 'ADD'
#       reg += stack.pop
#     when 'SUB'
#       reg -= stack.pop
#     when 'MULT'
#       reg *= stack.pop
#     when 'DIV'
#       reg /= stack.pop
#     when 'MOD'
#       reg %= stack.pop
#     when 'POP'
#       reg = stack.pop
#     when 'PRINT'
#       puts reg
#     else
#       reg = c.to_i
#     end
#   end
# end

def minilang(str_commands)
  commands = str_commands.split(" ")
  reg = 0
  stack = []
  commands.each do |c|
    if c.match(/[0-9]/)
      reg = c.to_i
    elsif c == 'PUSH'
      stack.push(reg)
    elsif c == 'PRINT'
      puts reg
    else
      begin
        case c
        when 'ADD'
          reg += stack.pop
        when 'SUB'
          reg -= stack.pop
        when 'MULT'
          reg *= stack.pop
        when 'DIV'
          reg /= stack.pop
        when 'MOD'
          reg %= stack.pop
        when 'POP'
          reg = stack.pop
        else
          puts "invalid command: \"#{c}\""
        end
      rescue NoMethodError
        puts "ERROR: empty stack (NoMethodError)"
      rescue TypeError
        puts "ERROR: empty stack (TypeError)"
      rescue ZeroDivisionError
        puts "ERROR: divided by zero (ZeroDivisionError)"
      end
    end
  end
end

minilang('PRINT')
# 0

minilang('5 PUSH 3 MULT PRINT')
# 15

minilang('5 PRINT PUSH 3 PRINT ADD PRINT')
# 5
# 3
# 8

minilang('5 PUSH POP PRINT')
# 5

minilang('3 PUSH 4 PUSH 5 PUSH PRINT ADD PRINT POP PRINT ADD PRINT')
# 5
# 10
# 4
# 7

minilang('3 PUSH PUSH 7 DIV MULT PRINT ')
# 6

minilang('4 PUSH PUSH 7 MOD MULT PRINT ')
# 12

minilang('-3 PUSH 5 SUB PRINT')
# 8

minilang('6 PUSH')
# (nothing printed; no PRINT commands)

minilang('3 PUSH 5 MOD PUSH 3 PUSH 7 PUSH 4 PUSH 5 MULT SUB ADD DIV PRINT')
# 8

minilang('a PUSH')

minilang('POP DIV')

minilang('DIV')

minilang('0 PUSH DIV')
