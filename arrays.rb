# Arrays 

array_1 = Array.new
array_2 = Array.new(5)
array_3 = Array.new(5,"default val")
array_4 = Array[1,"two",3,4,"five"]

puts array_1
puts array_2
puts array_3
puts array_4.join(",")

puts "print on index , starts at 0"
puts array_4[2]
puts "print on index , starts at 0, number of values"
puts array_4[2,3].join(",")

puts "print values at index points"
puts array_4.values_at(2,3).join(",")

# ads at front 
array_4.unshift("d")
puts array_4.join(",")

# removes from front
array_4.shift()
puts array_4.join(",")

# appends
array_4.push(100,200)
puts array_4.join(",")

# truncates at end
array_4.pop
puts array_4.join(",")

# truncates at end
array_4.concat([10,20,30])
puts array_4.join(",")

puts "Array size " + array_4.size.to_s
puts "Array contains 100 " + array_4.include?(100).to_s
puts "Array how many 100 " + array_4.count(100).to_s
puts "Array empty " + array_4.empty?.to_s
p array_4



array_4.each do |value|
    puts  "value is " + value.to_s
end

for number in array_4
    print number
end