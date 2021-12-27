# Cannot be instantaited  but can be used to add functionality to a class

require_relative "modhuman.rb"
require_relative "modsmart.rb"

# if the above are incorrect it doesnt throw an error

puts "**Running main**"

module Animal
  def make_sound
    puts "Grr !"
  end
end

class Dog
  include Animal
  attr_accessor :name
end

dog = Dog.new
dog.name = "Rover"

puts "Name is : " + dog.name
dog.make_sound


# -------------------------------

class Scientist
    include Human, Smart
    attr_accessor :name
end

einstein = Scientist.new
einstein.name = "Einstein"
puts einstein.name 
puts einstein.act_smart


