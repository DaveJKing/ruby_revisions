=begin
  comments.rb
  author Jan Bodnar


p "Enter a number :"
fnum = gets.to_i

print "Enter a second number :"
snum = gets.to_i

puts fnum.to_s + " + " + snum.to_s + " = " + (fnum + snum).to_s

=end

puts "6+5 = " + (6+4).to_s
puts "6-4 = " + (6-4).to_s
puts "6*4 = " + (6*4).to_s
puts "6/4 = " + (6/4).to_s
puts "6 mod 4 = " + (6%4).to_s

puts "6 div 4 = " + (6.div(4)).to_s
puts "6 divmod 4 = " + (6.divmod(4)).to_s

dm = (6.divmod(4))
puts dm.class 
puts 1.class 

puts 1.25464.class
puts "text".class

A_CONSTANT = 2
A_CONSTANT = 2

puts A_CONSTANT.even?

    



