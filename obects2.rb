class Dog
    # attr_reader :name, :height, :weight #setters
    # attr_writer :name, :height, :weight #getters

attr_accessor :name, :height, :weight    

    def bark
        return "Yelp"
    end
end

class GermanSepperd < Dog
    def bark
        return "WOOF"
    end
end

rover = Dog.new
rover.name = "Rover"

puts rover.name
puts rover.bark

max = GermanSepperd.new
max.name = "Max"
puts max.name
puts max.bark

printf "%s goes %s \n", max.name, max.bark()