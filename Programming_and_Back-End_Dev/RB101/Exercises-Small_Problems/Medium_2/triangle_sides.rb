def triangle(side1, side2, side3)
  sides = [side1, side2, side3]
  sides.sort!
  return :invalid if sides.include?(0) || (sides[2] > (sides[0] + sides[1]))
  return :equilateral if sides == sides.reverse
  return :scalene if sides.uniq.size == 3
  return :isosceles
end

puts triangle(3, 3, 3) == :equilateral
puts triangle(3, 3, 1.5) == :isosceles
puts triangle(3, 4, 5) == :scalene
puts triangle(0, 3, 3) == :invalid
puts triangle(3, 1, 1) == :invalid
