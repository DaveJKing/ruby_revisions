require_relative "lib/checkoutObjects.rb"
require_relative "lib/methods.rb"
puts "Running Checkout ........"

debug = true
puts (debug ? "Debug mode operating " : "Not in debug mode")

# Set rules for pricepolicy and discounts
# Item pricing policy would normally be consumed from a db.
# This is has global scope to facilitate that simulation

# Cater for loyalty cards

# Cater for handling where scanned item does not exist in db

class Checkout
  attr_accessor  :loyaltycardno, :items, :basket_total
  def initialize()
    @items = Hash.new
    @basket_total = 0
  end

  def scan(item,*loyaltyCardNoRef)
    if item.downcase != "clubcard"
      begin
          check = RULES.fetch(item)
      rescue => exception
          # item is not in stock database, handle and report 
          puts "*** Item not in inventoty database - Inform shopper Item removed fom sale to be polite. ***"
      else
          # add an initialise to 0 if not existing
          @items[item] ||= 0
          # increment item count +1, 
          @items[item] += 1
      end
    end 
    self.loyaltycardno =loyaltyCardNoRef[0].to_s unless loyaltyCardNoRef.empty?
  end
  

  def total_up
   
      # puts @items
      for item,itemQuanityPurchased in @items

          itemRule = RULES[item]
          itemRuleDiscount = itemRule.discounts[0]
          puts item
          puts itemRule.discounts[0].class.name

          case itemRule.discounts[0].class.name
          when "LinearDiscount", "lineardiscount"
              # Base price operates but discount price kicks in after quantity threshold

              if itemQuanityPurchased > itemRuleDiscount.quantity_threshold 
                  # "Discount threshold passed !"
                
                  baseTotal = itemRule.base_price * (itemRuleDiscount.quantity_threshold )
          
                  discountQty = itemQuanityPurchased - (itemRuleDiscount.quantity_threshold )
                  discountTotal = discountQty * itemRuleDiscount.discount_price
                  @basket_total += baseTotal + discountTotal
                        
              else
                  # "Discount threshold NOT reached !"
                  @basket_total += itemQuanityPurchased * itemRule.base_price
              end
          when "BatchDiscount", "batchdiscount"
              #  Buy n get y free, happens prefined times or perpetually
              # attr_reader :batch_threshold_trigger, :gets_free, :occurs
              puts "Batch discount item !"
              puts item
              puts (itemRuleDiscount.occurs == -1 ? "Discount is perpetual " : "Discount limited to  #{itemRuleDiscount.occurs} occurrance " )
              
              puts "Purchased itemQuanityPurchased #{itemQuanityPurchased}"
              puts "Buys #{itemRuleDiscount.buys}, Gets free  #{itemRuleDiscount.gets_free}"
              puts "Undiscounted price #{itemQuanityPurchased * itemRule.base_price}"


              if itemQuanityPurchased  >= itemRuleDiscount.buys 
                puts "Batch discount applies"

                discountMultiples = itemQuanityPurchased.div(itemRuleDiscount.buys)

                if itemRuleDiscount.occurs == -1 
                  # Discount applies to whole purchase for this item
                  total = (itemQuanityPurchased - ( discountMultiples * itemRuleDiscount.gets_free)) * itemRule.base_price
                else
                  # Limited discount applies e.g n per customer
                  puts "Limited discount applies e.g n per customer"
                  total = (itemQuanityPurchased - ( itemRuleDiscount.occurs * itemRuleDiscount.gets_free)) * itemRule.base_price
                end
                

                puts "Total : #{total}"
              else
                # No discount 
                puts "No batch discount applies"
               
                total = itemQuanityPurchased * itemRule.base_price
                puts "Total : #{total}"
              end

              @basket_total += total
          when "PercentDiscount", "percentdiscount"
               puts "Percent discount"

               undiscountedTotal = itemQuanityPurchased * itemRule.base_price
               discount = (undiscountedTotal * itemRuleDiscount.percentile)/100
               total = undiscountedTotal - discount
               puts "Total : #{total}"
               @basket_total += total
          else
              #  This section shoul only apply to items without a discount policy,
              #  check for unknown policy class
              puts "No discount"
              if itemRule.discounts[0].class.name == "NilClass"
                @basket_total += itemQuanityPurchased * itemRule.base_price
              else
                puts "*** Unable to cater for Discount policy - Inform shopper Item removed fom sale to be polite. ***"
                puts "*** Handle by reporting to systems team via e.g sentry  ***"
              end
          end
       end      
  end
end


RULES = {
  # 2 for 1 apple (half price)
  "apple" => PricePolicy.new(10, BatchDiscount.new(2, 1, -1)), #bogoff
  "orange" => PricePolicy.new(20),
  "pear" => PricePolicy.new(15),
  # half price bananas
  "banana" => PricePolicy.new(30, PercentDiscount.new(50)),
  "pineapple" => PricePolicy.new(100, BatchDiscount.new(2, 1, 1)),
  "mango" => PricePolicy.new(200, BatchDiscount.new(3, 1, 1)),
  "rogue" => PricePolicy.new(30, RogueDiscount.new(50)),
  
 

  # "apple" => PricePolicy.new(10, LinearDiscount.new(30, 3)),
  # "orange" => PricePolicy.new(20, LinearDiscount.new(15, 2)),
  # "pear" => PricePolicy.new(20),
  # "banana" => PricePolicy.new(15),
  # "pineapple" => PricePolicy.new(30, BatchDiscount.new(2, 1, 1)),
  # # Above buy 2 get 1 free , only one cycle
  
  # "mango" => PricePolicy.new(50, BatchDiscount.new(3, 1, 1)),
  # "mango" => PricePolicy.new(50, BatchDiscount.new(3, 2, -1)),
  # Above buy 2 get 1 free , perpetual  i.e no limit
}

checkout = Checkout.new


checkout.scan("pear")
# checkout.scan("apple")
# checkout.scan("apple")
# checkout.scan("apple")

checkout.scan("rogue")

checkout.scan("mango")
checkout.scan("mango")
checkout.scan("mango")
# checkout.scan("mango")

# checkout.scan("banana")
# checkout.scan("banana")

# checkout.scan("apple")
#  checkout.scan("apple")
#checkout.scan("apple")
# checkout.scan("orange")
# checkout.scan("A")
# checkout.scan("A")
# checkout.scan("D")
# checkout.scan("X")
# checkout.scan("F")
checkout.scan("Clubcard","123456")
checkout.scan("Clubcard","6666666")

puts (checkout.loyaltycardno.nil? ? "No loyalty card scanned " : "Loyalty card #{checkout.loyaltycardno} was scanned " )

checkout.total_up

puts "Basket total : #{checkout.basket_total.to_s} pence"
puts "End of checkout !"
