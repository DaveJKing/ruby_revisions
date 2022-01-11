# require "checkoutobjects.rb"
# require_relative "methods.rb"
# require_relative "dbstuff.rb"

class PricePolicy
    attr_reader :base_price, :discounts
  
    def initialize(base_price, *discounts)
      @base_price = base_price
      @discounts = discounts
    end
end


  
class LinearDiscount
    # Base price operates but discount price kicks in after quantity threshold
    attr_reader :discount_price, :quantity_threshold
  
    def initialize(discount_price, quantity_threshold)
      @discount_price = discount_price
      @quantity_threshold = quantity_threshold
    end
  end
  
  class BatchDiscount
    #  Buy n get y free, happens prefined times or perpetually
    attr_reader :buys, :gets_free, :occurs_max
  
    def initialize(buys, gets_free, occurs_max)
      @buys = buys
      @gets_free = gets_free
      @occurs_max = occurs_max
    end
  end
  
  class PercentDiscount
    #  Precentage reductio e.g half price = -50%
    attr_reader :percentile
  
    def initialize(percentile)
      @percentile = percentile
    end
  end
  
  # For system testing only
  class RogueDiscount
    attr_reader :percentile
  
    def initialize(percentile)
      @percentile = percentile
    end
  end


class Checkout
    attr_accessor  :loyaltycardno, :items, :basket_total,:db


    RULES = {
    
        "apple" => PricePolicy.new(10, BatchDiscount.new(2, 1, -1)), #bogoff
        "orange" => PricePolicy.new(20),
        "pear" => PricePolicy.new(15),
        "banana" => PricePolicy.new(30, PercentDiscount.new(50)),
        "pineapple" => PricePolicy.new(100, BatchDiscount.new(2, 1, 1)),
        "mango" => PricePolicy.new(200, BatchDiscount.new(3, 1, 1)),
        "rogue" => PricePolicy.new(30, RogueDiscount.new(50)), 
      }

    def price_rules
        RULES
    end

    def initialize()
        @items = Hash.new
        @basket_total = 0  
        @db = price_rules
    end
  
  
    def scan(item,*loyaltyCardNoRef)
      if item.downcase != "clubcard"
        begin
          puts "item #{item}"
          
           check = @db.fetch(item)
        rescue => exception
            puts "*** Item not in inventory database,report - Inform shopper Item removed fom sale to be polite. ***"
        else
            # add an initialise to 0 if not existing
            @items[item] ||= 0
            @items[item] += 1
        end
      end 
      self.loyaltycardno =loyaltyCardNoRef[0].to_s unless loyaltyCardNoRef.empty?
    end
    
  
    def total
        @basket_total = 0
        puts @items
        for item,itemQuanityPurchased in @items
  
            itemRule = @db[item]
            itemRuleDiscount = itemRule.discounts[0]
            
            case itemRule.discounts[0].class.name
            when "LinearDiscount", "lineardiscount"
                # Base price operates but discount price kicks in after quantity threshold
  
                if itemQuanityPurchased > itemRuleDiscount.quantity_threshold 
                    # "Discount threshold reached !"
                  
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
                
                # puts "Batch discount item !"
                # puts item
                
                # puts "Purchased itemQuanityPurchased #{itemQuanityPurchased}"
                # puts "Buys #{itemRuleDiscount.buys}, Gets free  #{itemRuleDiscount.gets_free}"
                # puts "Undiscounted price #{itemQuanityPurchased * itemRule.base_price}"
  
                puts (itemRuleDiscount.occurs_max == -1 ? "Discount is perpetual " : "Discount limited to  #{itemRuleDiscount.occurs_max} occurrances " )
               
  
                if itemQuanityPurchased  >= itemRuleDiscount.buys 
                  puts "Batch discount applies"
  
                  discountMultiples = itemQuanityPurchased.div(itemRuleDiscount.buys)
  
                  if itemRuleDiscount.occurs_max == -1 
                    # Discount applies to whole purchase for this item
                    total = (itemQuanityPurchased - ( discountMultiples * itemRuleDiscount.gets_free)) * itemRule.base_price
                  else
                    # Limited discount applies i.e n per customer
                    puts "Limited discount applies e.g n per customer"
                    total = (itemQuanityPurchased - ( itemRuleDiscount.occurs_max * itemRuleDiscount.gets_free)) * itemRule.base_price
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
                  puts "*** Unable to cater for Discount policy - Inform shopper Item removed from sale to be polite. ***"
                  puts "*** Handle by reporting to systems team via e.g sentry  ***"
                end
            end
        end      
    end
  end
  
  
  



