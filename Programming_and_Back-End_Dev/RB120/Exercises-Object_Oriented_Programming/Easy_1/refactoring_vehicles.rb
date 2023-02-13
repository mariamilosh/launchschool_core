class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

# It wouldn't make sense for Vehicle to have a wheels method since not all
# Vehicles have wheels. For instance, a boat or a helicopter are both vehicles
# as well as submersible vehicles. It would make more sense to add another layer
# of subclasses between Vehicle and the current subclasses to differentiate
# road vehicles, watercraft, aircraft, etc. or create a module that includes
# behavior specific to wheeled vehicles that can be added to those classes
# that require it. Module would be the preferred way since some vehicles may fit
# into multiple categories like airplanes being aircraft but also having wheels.
