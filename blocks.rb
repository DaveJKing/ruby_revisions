=begin
multiline
 commnets go here
=end



 puts [2, -1, -4, 0].delete_if { |x| x < 0 }


 puts "____________________________________"

 [2, -1, -4, 0].each do |e|
    if (e >= 0) then
        puts e
    end
end

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
