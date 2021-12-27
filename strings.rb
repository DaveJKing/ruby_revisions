fname = "Dave"
lname = "King"

fullname = fname + lname

mname = "middle"

fullname = "#{fname} #{mname} #{lname}"

puts fullname


puts fullname.include?("Dave")
puts fullname.include? "Davee"

puts fullname.size

puts "Vowels :" + fullname.count("aeiou").to_s

puts "Not Vowels :" + fullname.count("^aeiou").to_s

puts fullname.start_with? "Dave"

puts "Index : " + fullname.index("ing").to_s

ind = fullname.index("ing")
ind2 = ind + 1

puts fullname[ind..ind +1].to_s


puts fname
puts fname.eql?("Dave")
puts fname.downcase.eql?("Dave")

stripname = "      " + fname

stripname = stripname.lstrip

puts  stripname.lstrip
puts stripname.rstrip
puts stripname.strip

puts stripname.tr("D","R")

name_array = fullname.split(//)
puts name_array
name_array = fullname.split(/ /)
puts name_array

print "end"


