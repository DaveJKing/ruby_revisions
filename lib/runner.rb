require_relative "checkout.rb"
# require_relative "methods.rb"
# require_relative "dbstuff.rb"

puts "Running Checkout ........"

debug = true
puts (debug ? "Debug mode operating " : "Not in debug mode")

# ***************************************************************
# Cater for loyalty cards
# Cater for handling where scanned item does not exist in db
# Cater for unknown discount policy 'RogueDiscount'
# ***************************************************************

# DB_VIEW = connectdb

if debug

  # Set rules for pricepolicy and discounts
  # Item pricing policy would normally be consumed from a db.
  # This is has global scope to facilitate that simulation

  checkout = Checkout.new

  checkout.scan("apple")
  checkout.scan("apple")
  checkout.scan("marrow")
  checkout.scan("rogue")
  # checkout.scan("pineapple")

  checkout.totalUp

  checkout.scan("orange")
  checkout.totalUp

  puts "Basket discounted total : #{checkout.basket_discounted_total.to_s} pence"
  puts "Basket NON discounted total : #{checkout.basket_non_discounted_total.to_s} pence"

  # checkout.scan("apple")
  # checkout.scan("apple")

  # checkout.scan("Clubcard","123456")
  # checkout.scan("Clubcard","6666666")

  # puts (checkout.loyaltycardno.nil? ? "No loyalty card scanned " : "Loyalty card #{checkout.loyaltycardno} was scanned " )

  # checkout.totalUp

  # puts "Basket discounted total : #{checkout.basket_discounted_total.to_s} pence"
  # puts "Basket NON discounted total : #{checkout.basket_non_discounted_total.to_s} pence"

end

puts "End of checkout !"
