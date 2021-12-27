class Animal
  def initialize
    puts "Creating Animal"
  end

  def set_name(name)
    if name.is_a?(String)
      @name = name
    else
      puts "Name is not a string"
    end
  end

  def get_name
    return @name
  end

  #   Alternatieves
  #  get
  def name
    puts "running alt getter"
    @name
  end

  #  set
  def name=(new_name)
    puts "running alt setter"
    if new_name.is_a?(String)
      @name = new_name
    else
      puts "Name is not a string"
    end
  end
end

cat = Animal.new

cat.set_name("Tiger")
puts cat.get_name

#  Alt

cat.name = "Tiger2"
puts cat.name

cat.name = 22
puts cat.name

puts "end"
