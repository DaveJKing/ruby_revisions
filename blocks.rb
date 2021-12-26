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


