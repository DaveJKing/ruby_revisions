# require_relative "methods.rb"
require_relative "dbstuff.rb"



class Checkout
    attr_accessor  :loyaltycardno, :items, :basket_discounted_total, :basket_non_discounted_total,:db

    def initialize()
        @items = Hash.new
        
        @basket_discounted_total = 0  
        @basket_non_discounted_total = 0  

        @dbconnect = Db.new
    end
  
  
    def scan(item,*loyaltyCardNoRef)
      if item.downcase != "clubcard"
        
           check = @dbconnect.select(item)

           if check != nil
                @items[item] ||= 0
                @items[item] += 1
           else
                puts "*** Item not in inventory database,report - Inform shopper Item removed fom sale to be polite. ***"
           end
        
      end 
      self.loyaltycardno =loyaltyCardNoRef[0].to_s unless loyaltyCardNoRef.empty?
    end
    
  
    def totalUp
        @basket_discounted_total  = 0  
        @basket_non_discounted_total = 0 
       
        for item,itemQuanityPurchased in @items
  
            itemRule = @dbconnect.select(item)

            @basket_non_discounted_total += (itemQuanityPurchased * itemRule.base_price)

            itemRuleDiscount = itemRule.discounts[0]
            
            case itemRule.discounts[0].class.name
            when "LinearDiscount", "lineardiscount"
                # Base price operates but discount price kicks in after quantity threshold
  
                if itemQuanityPurchased > itemRuleDiscount.quantity_threshold 
                    # "Discount threshold reached !"
                  
                    baseTotal = itemRule.base_price * (itemRuleDiscount.quantity_threshold )
            
                    discountQty = itemQuanityPurchased - (itemRuleDiscount.quantity_threshold )
                    discountTotal = discountQty * itemRuleDiscount.discount_price
                    @basket_discounted_total += baseTotal + discountTotal
                          
                else
                    # "Discount threshold NOT reached !"
                    @basket_discounted_total += itemQuanityPurchased * itemRule.base_price
                end
            when "BatchDiscount", "batchdiscount"
                #  Buy n get y free, happens prefined times or perpetually
                
               
                puts (itemRuleDiscount.occurs_max == -1 ? "Discount strategy is infinite for #{item}  " : "Discount strategy is limited to  #{itemRuleDiscount.occurs_max} occurrences for #{item} " )
               
  
                if itemQuanityPurchased  >= itemRuleDiscount.buys 
                  puts "Batch discount applies for #{item} "
  
                  discountMultiples = itemQuanityPurchased.div(itemRuleDiscount.buys)
  
                  if itemRuleDiscount.occurs_max == -1 
                    # Discount applies to whole purchase for this item
                    subTotal = (itemQuanityPurchased - ( discountMultiples * itemRuleDiscount.gets_free)) * itemRule.base_price
                  else
                    # Limited discount applies i.e n per customer
                    puts "Limited discount applies e.g n per customer for #{item} "
                    subTotal = (itemQuanityPurchased - ( itemRuleDiscount.occurs_max * itemRuleDiscount.gets_free)) * itemRule.base_price
                  end
                 
                else
                  # No discount 
                  puts "No batch discount applies for #{item} "
                  subTotal = itemQuanityPurchased * itemRule.base_price
                end
  
                @basket_discounted_total += subTotal
            when "PercentDiscount", "percentdiscount"
                 puts "Percent discount"
  
                 undiscountedTotal = itemQuanityPurchased * itemRule.base_price
                 discount = (undiscountedTotal * itemRuleDiscount.percentile)/100
                 subTotal = undiscountedTotal - discount
               
                 @basket_discounted_total += subTotal
            else
                #  This section should only apply to items without a discount policy,
                #  check for unknown policy class
                puts "No discount scheme for #{item} "
                if itemRule.discounts[0].class.name == "NilClass"
                    @basket_discounted_total += itemQuanityPurchased * itemRule.base_price
                else
                  puts "*** Unable to cater for Discount policy - Inform shopper Item removed from sale to be polite. ***"
                  puts "*** Handle by reporting to systems team via e.g sentry  ***"
                end
            end
        end      
    end
end
  
  
  



