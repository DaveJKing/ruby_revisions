require_relative "lib/checkoutObjects.rb"
require_relative "lib/methods.rb"
puts "Running Checkout ........"

debug = true
puts (debug ? "Debug mode operating " : "Not in debug mode")

# Set rules for priceplocy and discounts
# Item pricing policy would normally be consumed from a db.
# This is has global scope to facilitate that simulation

RULES = {
  "A" => PricePolicy.new(50, LinearDiscount.new(30, 3)),
  "B" => PricePolicy.new(30, LinearDiscount.new(15, 2)),
  "C" => PricePolicy.new(20),
  "D" => PricePolicy.new(15),
  "E" => PricePolicy.new(30, BatchDiscount.new(2, 1, 1)),
  # Above buy 2 get 1 free , only one cycle
  "F" => PricePolicy.new(30, BatchDiscount.new(3, 2, -1)),
  # Above buy 2 get 1 free , perpetual  i.e no limit
}



checkout = Checkout.new
checkout.scan("A")
checkout.scan("A")
checkout.scan("A")
checkout.scan("A")
# checkout.scan("X")

checkout.scan("Clubcard","123456")

puts (checkout.loyaltycardno.nil? ? "No loyalty card scanned " : "Loyalty card #{checkout.loyaltycardno} was scanned " )

checkout.total_up
puts "Basket total : #{checkout.basket_total.to_s} pence"

puts "End of checkout !"
