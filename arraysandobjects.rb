require_relative "lib/checkoutObjects.rb"
require_relative "lib/methods.rb"
puts "Running Checkout ........"

debug = true
puts (debug ? "Debug mode operating " : "Not in debug mode")

# Set rules for priceplocy and discounts
# Item pricing policy would normally be consumed from a db.

RULES = {
  "A" => PricePolicy.new(50, LinearDiscount.new(20, 3)),
  "B" => PricePolicy.new(30, LinearDiscount.new(15, 2)),
  "C" => PricePolicy.new(20),
  "D" => PricePolicy.new(15),
  "E" => PricePolicy.new(30, BatchDiscount.new(2, 1, 1)),
  # Above buy 2 get 1 free , only one cycle
  "F" => PricePolicy.new(30, BatchDiscount.new(3, 2, -1)),
# Above buy 2 get 1 free , perpetual  i.e no limit
}

class Checkout

  attr_accessor  :loyaltycardno, :items

  def initialize()
    @items = Hash.new
  end

  def scan(item,*loyaltyCardNoRef)

    if item.downcase != "clubcard"
      @items[item] ||= 0
      @items[item] += 1
    end
   
    print "Scanned item #{item} " 
    self.loyaltycardno =loyaltyCardNoRef[0].to_s unless loyaltyCardNoRef.empty?
  end
  
end

co = Checkout.new
co.scan("A")
co.scan("A")
co.scan("B")
co.scan("Clubcard","123456")
co.scan("A")
co.scan("C")
co.scan("F")
# co.scan("Clubcard","123456")
# co.scan("Voucher","999")

puts (co.loyaltycardno.nil? ? "No loyalty card" : "Loyalty card #{co.loyaltycardno} was scanned " )

# puts RULES
# puts (RULES.has_key?("A") ? "Key exists :-) " : "Key does not exist :-(")

itemHash = co.items
for item,number in itemHash
  puts "#{item},#{number}"
  showDiscountStrategy(RULES[item],debug)
end

# itemRule = RULES["A"]
# showDiscountStrategy(itemRule,debug)


puts "End of checkout !"
