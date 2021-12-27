class Bird

    attr_accessor :name
    def tweet(bird_type)
        bird_type.tweet
    end
end

class Pidgeon < Bird
    def tweet
        puts "Coo"
    end
end

class Parrot < Bird
    def tweet
        puts "Squauk!!"
    end
end

generic_bird = Bird.new
generic_bird.name = "Bob"
generic_bird.tweet(Pidgeon.new)
generic_bird.tweet(Parrot.new)

puts generic_bird.name

