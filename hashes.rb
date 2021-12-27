# groups of named pairs

number_hash = {"PI" => 3.14, "Golden" => 1.618, "e" => 2.788}
puts number_hash["PI"]

superheroes = Hash["Clark Kent","Superman",
                    "Bruce Wayne","Batman"]

puts superheroes["Clark Kent"]

superheroes["Barry Allen"]= "Flash"

superheroines = Hash["Lisa Morel","Aquagirl","Betty Kane","Batgirl","Bruce Wayne","Batman"]


# Merge that eliminates duplicates or use .merge to keep duplicates
superheroes.update(superheroines) 
puts "---------------------------------"
puts "block loop"
superheroes.each do |key,value|
    puts key.to_s + " :" + value
end



puts "---------------------------------"
puts "modified loop"
for key,hero in superheroes
    puts key.to_s + " :" + hero
end
puts "---------------------------------"
puts
puts "Has Key Lisa Morel : " + superheroes.has_key?("Lisa Morel").to_s
puts "Has value Batman : " + superheroes.has_value?("Batman").to_s
puts "Is hash empty : " + superheroes.empty?.to_s
puts "Size of hash : " + superheroes.size.to_s

puts "deleting one"
superheroes.delete("Barry Allen")
puts "Size of hash : " + superheroes.size.to_s


puts "The end"