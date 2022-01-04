require_relative "lib/checkoutObjects.rb"
require_relative "lib/methods.rb"
puts "Running Checkout ........"

debug = true
puts (debug ? "Debug mode operating " : "Not in debug mode")

# Set rules for priceplocy and discounts
# Item pricing policy would normally be consumed from a db.

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
   
    print "Scanned item #{item},  " 
    self.loyaltycardno =loyaltyCardNoRef[0].to_s unless loyaltyCardNoRef.empty?
  end
  
end

co = Checkout.new
co.scan("A")
co.scan("A")
co.scan("A")
co.scan("A")
co.scan("A")
# co.scan("B")
 co.scan("Clubcard","123456")
# co.scan("A")
# co.scan("C")
# co.scan("F")
# co.scan("Clubcard","123456")
# co.scan("Voucher","999")

puts (co.loyaltycardno.nil? ? "No loyalty card scanned " : "Loyalty card #{co.loyaltycardno} was scanned " )

# puts RULES
# puts (RULES.has_key?("A") ? "Key exists :-) " : "Key does not exist :-(")

itemHash = co.items
for item,itemQuanityPurchased in itemHash
  puts "#{item},#{itemQuanityPurchased}"
  showDiscountStrategy(RULES[item],debug)

  itemRule = RULES[item]
  itemRuleDiscount = itemRule.discounts[0]

  puts itemRule.base_price
  puts "Discount price is #{itemRuleDiscount.discount_price}, kicks in after purchase quantity #{itemRuleDiscount.quantity_threshold } "


  # linear
  if itemQuanityPurchased > itemRuleDiscount.quantity_threshold 
    puts "Threshold passed !"
    baseTotal = itemRule.base_price * (itemRuleDiscount.quantity_threshold )

    discountQty = itemQuanityPurchased - (itemRuleDiscount.quantity_threshold )
    discountTotal = discountQty * itemRuleDiscount.discount_price
    total = baseTotal + discountTotal
  
  else
    puts "NOT Threshold reached !"
    total = itemQuanityPurchased * itemRule.base_price
  end

  puts "Total : #{total}"

end



# itemRule = RULES["A"]
# showDiscountStrategy(itemRule,debug)


puts "End of checkout !"
