

# define enumerable class 

class Menu
    include Enumerable
    def each
        yield "pizza"
        yield "spaghetti"
        yield "salad"
    end
end

menu_options = Menu.new

for item in menu_options
    puts "Would you like :" + item.to_s
end

 # Check to see if we have pizza
p menu_options.find {|item| item == "pizza"}
 
# Return items 5 letters in length
p menu_options.select {|item| item.size <= 5}
 
# Reject items that meet the criteria
p menu_options.reject {|item| item.size <= 5}
 
# Return the first item
p menu_options.first
 
# Return the first 2
p menu_options.take(2)
 
# Return the everything except the first 2
p menu_options.drop(2)
 
# Return the minimum item
p menu_options.min
 
# Return the maximum item
p menu_options.max
 
# Sort the items
p menu_options.sort
 
# Return each item in reverse order
menu_options.reverse_each {|item| puts item}