# class Pet
#   attr_reader :type, :name
#   # @@total_pets = 0
#
#   def initialize(pet_type, pet_name)
#     @type = pet_type
#     @name = pet_name
#     # @@total_pets += 1
#     # Shelter.put_in_shelter(self)
#   end
#
#   # private
#   #
#   # def put_in_shelter
#   #   Shel
#   # end
# end
#
# class Owner
#   attr_reader :name
#
#   def initialize(name)
#     @name = name
#   end
#
#   def number_of_pets
#     # Shelter.pet_array(self).size
#   end
# end
#
# class Shelter
#   @adoptions = {}
#   @unadopted_pets = []
#
#   def adopt(owner, pet)
#     if @adoptions.key?(owner)
#       @adoptions[owner] << @unadopted_pets.delete(pet)
#     else
#       @adoptions[owner] = [@unadopted_pets.delete(pet)]
#     end
#   end
#
#   def print_adoptions
#     @adoptions.each do |owner, pets|
#       puts "#{owner.name} has adopted the following pets:"
#       pets.each do |pet|
#         puts "a #{pet.type} named #{pet.name}"
#       end
#       puts ""
#     end
#   end
#
#   def print_unadopted_pets
#     puts "The Animal Shelter has the following unadopted pets:"
#     @unadopted_pets.each do |pet|
#       puts "a #{pet.type} named #{pet.name}"
#     end
#   end
#
#   def pet_array(owner)
#     @adoptions[owner]
#   end
#
#   protected
#
#   def put_in_shelter(pet)
#     @unadopted_pets << pet
#   end
# end
########################################################################
# class Pet
#   attr_reader :animal, :name
#
#   def initialize(animal, name)
#     @animal = animal
#     @name = name
#   end
#
#   def to_s
#     "a #{animal} named #{name}"
#   end
# end
#
# class Owner
#   attr_reader :name, :pets
#
#   def initialize(name)
#     @name = name
#     @pets = []
#   end
#
#   def add_pet(pet)
#     @pets << pet
#   end
#
#   def number_of_pets
#     pets.size
#   end
#
#   def print_pets
#     puts pets
#   end
# end
#
# class Shelter
#   def initialize
#     @owners = {}
#   end
#
#   def adopt(owner, pet)
#     owner.add_pet(pet)
#     @owners[owner.name] ||= owner
#   end
#
#   def print_adoptions
#     @owners.each_pair do |name, owner|
#       puts "#{name} has adopted the following pets:"
#       owner.print_pets
#       puts
#     end
#   end
# end

#####################################################################

# initialize must accept pet type and pet name
class Pet
  attr_reader :type, :name
  # @@all_pets = []
  @@unadopted_pets = []

  def initialize(pet_type, pet_name)
    @type = pet_type
    @name = pet_name
    # @@all_pets << self
    @@unadopted_pets << self
  end

  def to_s
    "a #{type} named #{name}"
  end

  def self.unadopted_pets
    @@unadopted_pets
  end
end

# initialize must accept owner name
# must have name method
# must have number_of_pets method
class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def adopt_pet(pet)
    # @pets << pet
    @pets << Pet.unadopted_pets.delete(pet)
  end

  def number_of_pets
    pets.size
  end

  def print_pets
    puts pets
  end
end

# must have adopt method that accepts owner object and pet object
# must have print_adoptions method
# print method for unadopted pets
class Shelter
  # attr_reader :adoptions

  def initialize
    @owners = {}
  end

  def adopt(owner, pet)
    owner.adopt_pet(pet)
    @owners[owner.name] ||= owner
  end

  def print_adoptions
    @owners.each_pair do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts
    end

  end

  def print_unadopted_pets
    puts "The Animal Shelter has the following unadopted pets:"
    puts Pet.unadopted_pets
  end

  def number_of_unadopted_pets
    Pet.unadopted_pets.size
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts ""
asta         = Pet.new('dog', 'Asta')
laddie       = Pet.new('dog', 'Laddie')
fluffy       = Pet.new('cat', 'Fluffy')
kat          = Pet.new('cat', 'Kat')
ben          = Pet.new('cat', 'Ben')
chatterbox   = Pet.new('parakeet', 'Chatterbox')
bluebell     = Pet.new('parakeet', 'Bluebell')
shelter.print_unadopted_pets
puts ""
puts "The Animal Shelter has #{shelter.number_of_unadopted_pets} unadopted pets."
puts ""
shelter.adopt(phanson, bluebell)
shelter.adopt(phanson, laddie)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts ""

shelter.print_unadopted_pets
puts "The Animal Shelter has #{shelter.number_of_unadopted_pets} unadopted pets."
