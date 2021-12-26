age  = 15

 if (age >=5 && age <=6)
    puts "go to kindergarten"
 elsif (age >=7 && age <=13)
    puts "your in middle school"
 else
    puts "Stay home"
 end

unless age > 4 
    puts "No School"
else
    puts "Go to school"
end


puts "You are old " if (age > 12)


#------------------------------------

# print "Enter Greeting"
# greeting = gets.chomp.downcase

greeting = "french"

# case greeting
# when "french"
#     puts "bonjour"
#     exit
# when "spanish"
#     puts "Hola"
#     exit
# else 'English'
#     puts "Hello"
# end
    
# puts (age >=50) ? "Old":"Young"

#--------------------------------
x=1
loop do
        x+=1

    next unless (x%2)==0
    
        puts x.to_s + " ," + (x%2).to_s
    
    break if x >=10
end
#---------------------------------
y =1
while y <=10
    y += 1
    next unless(y%2)==0
    puts y
end


# ----------------------

numbers = [1,2,3,4,5]

puts ""
puts "---------------"

for number in numbers
    print number
end
puts ""
puts "---------------"


numbers.each do |number|
    print number
end 
puts ""
puts "---------------"


numbers.each_with_index do |number,index|
    print "(" + number.to_s + "," + index.to_s + ")"
    
end 
puts ""
puts "------------"

  