write_handler = File.open("test.txt","w")
write_handler.puts("random text1").to_s
write_handler.puts("random text2").to_s
write_handler.close


data_from_file = File.read("test.txt")
puts "Data from file : " + data_from_file

# Or
File.foreach("test.txt") { |line| puts line }

load "loadingexample.rb"

