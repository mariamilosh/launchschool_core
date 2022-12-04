class Vehicle
  @@how_many = 0
  def initialize(y, c, m)
    @@how_many += 1
    @speed = 0
    @year = y
    @color = c
    @model = m
  end
  def self.how_many
    puts "This program has created #{@@how_many} vehicles"
  end

  def speed_up=(s)
    self.speed += s
  end

  def brake=(s)
    if s > self.speed
      self.speed = 0
    else
      self.speed -= s
    end
  end

  def shut_off
    self.speed = 0
  end

  def spray_paint(c)
    @color = c
  end

  def self.gas_mileage(miles, gallons)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def self.print_vehicle_number
    puts "There are #{@@how_many} vehicles"
  end

  def age
    "The vehicle is #{years_old} years old"
  end

  private

  def years_old
    Time.now.year - @year
  end
end

module Towable
  def can_tow?(pounds)
    pounds < 2000
  end
end

class MyCar < Vehicle
  attr_accessor :color, :model, :speed
  attr_reader :year
  VEHICLE_TYPE = 'sedan'
  # @@mileage



  def to_s
    "The car is a #{@color} #{@year} #{@model}"
  end
end

class MyTruck < Vehicle
  include Towable
  VEHICLE_TYPE = 'truck'
end

car = MyCar.new(1992, 'blue', 'civic')
p car.model
p car.year
p car.color
p car.speed
car.spray_paint('orange')
p car.color
car.speed_up = 10
MyCar.gas_mileage(40, 9)
p car.shut_off
p car.speed
p car.to_s

puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors


class Student
  def initialize(n, g)
    @name = n
    @grade = g
  end
  def better_grade_than?(student)
    grade > student.grade
  end
  protected
  def grade
    @grade
  end
end
joe = Student.new("Joe", 90)
bob = Student.new("Bob", 84)
puts "Well done!" if joe.better_grade_than?(bob)
