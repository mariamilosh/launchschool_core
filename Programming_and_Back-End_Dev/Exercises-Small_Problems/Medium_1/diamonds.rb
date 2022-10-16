def diamond(num)
  rows = []
  count = num
  spaces = 0
  rows << "*" * num
  while count > 1 do
    count -= 2
    spaces += 1
    rows.push(" " * spaces + "*" * count)
    rows.unshift(" " * spaces + "*" * count)
  end
  rows.each { |row| puts row }
end

def diamond_outline(num)
  rows = []
  count = num
  outer_spaces = 0
  num == 1 ? rows << "*" : rows << "*" + " " * (num - 2) + "*"
  while count > 1 do
    count -= 2
    outer_spaces += 1
    if count == 1
      rows.push(" " * outer_spaces + "*")
      rows.unshift(" " * outer_spaces + "*")
    else
      rows.push(" " * outer_spaces + "*" + " " * (count - 2) + "*")
      rows.unshift(" " * outer_spaces + "*" + " " * (count - 2) + "*")
    end
  end
  rows.each { |row| puts row }
end

diamond(1)
diamond(3)
diamond(9)

diamond_outline(1)
diamond_outline(3)
diamond_outline(9)
