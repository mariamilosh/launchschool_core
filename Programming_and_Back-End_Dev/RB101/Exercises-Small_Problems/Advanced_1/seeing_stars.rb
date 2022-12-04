def star(num)
  star_assemble(num).each do |row|
    row.each do |val|
      print val
    end
    puts ""
  end
end

def star_rows(num)
  arr = []
  row_var = num
  count = 0
  while row_var > 1 do
    arr << []
    num_spaces = (row_var - 3) / 2
    count.times { arr[-1] << ' ' }
    arr[-1] << "*"
    num_spaces.times { arr[-1] << ' ' }
    arr[-1] << "*"
    num_spaces.times { arr[-1] << ' ' }
    arr[-1] << "*"
    row_var -= 2
    count += 1
  end
  arr
end

def star_assemble(num)
  star_arr = []
  star_arr += star_rows(num)
  star_arr << []
  num.times { star_arr[-1] << '*' }
  star_arr += star_rows(num).reverse
end

star(7)
star(9)
star(11)
star(23)
