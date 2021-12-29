puts "start dvd"
  class DVD
    @@array = Array.new
    attr_accessor :title, :year

    def self.all_instances
        @@array
    end
    
    def initialize(title,year)
        @title = title
        @year = year
        @@array << self
    end
  end

DVD.new("Gone with the wind",1985)
DVD.new("Shrek",1985)

all_dvd = DVD.all_instances
x = all_dvd.find{ |dvd| dvd.title == "Shrek"}

x = all_dvd.find{ |dvd| dvd.title == "Jaws"}

puts "not found" if x.nil?
puts "found" if x.nil? == false

    


# all_dvd.each_with_index do |index,title,year|
#     # print "(" + title.to_s + "," + index.to_s + ")"
#     puts title
# end 

#   for number in numbers
#     print number
# end
#   disc.title =  "Gone with the wind"
#   disc.year = 1985

  puts "end"