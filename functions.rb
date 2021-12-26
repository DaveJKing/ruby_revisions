def add_nums(num1, num2)
  return num1 + num2
end

puts add_nums(3, 4)

# ==========================

num1 = 1
num2 = 0

begin
  answer = num1 / num2
rescue => exception
  puts " you cant divide by 0 : num2 value is #{num2}"
end

#Raise own exception

def check_age(age)
  raise ArgumentError, "Enter positive number" unless age > 0
end

begin
  check_age(-1)
rescue ArgumentError
  puts "Impossible age!"
end

chars = "a.b.c"

x = chars.split(",").length
puts "length : #{x}"
