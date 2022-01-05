puts "Loading objects ....."

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
            puts "Inform shopper Item removed fom sale to be polite."
        else
            @items[item] ||= 0
            @items[item] += 1
        end
      end 
      self.loyaltycardno =loyaltyCardNoRef[0].to_s unless loyaltyCardNoRef.empty?
    end
    

    def total_up
    
        for item,itemQuanityPurchased in @items
        
            itemRule = RULES[item]
            itemRuleDiscount = itemRule.discounts[0]

            case itemRule.discounts[0].class.name
            when "LinearDiscount", "lineardiscount"
                if itemQuanityPurchased > itemRuleDiscount.quantity_threshold 
                    # "Discount threshold passed !"
                  
                  baseTotal = itemRule.base_price * (itemRuleDiscount.quantity_threshold )
            
                  discountQty = itemQuanityPurchased - (itemRuleDiscount.quantity_threshold )
                  discountTotal = discountQty * itemRuleDiscount.discount_price
                  @basket_total = baseTotal + discountTotal
                
                else
                    # "Discount hreshold NOT reached !"
                    @total_total = itemQuanityPurchased * itemRule.base_price
                end
            end
         end
    end

end

class PricePolicy
  attr_reader :base_price, :discounts

  def initialize(base_price, *discounts)
    @base_price = base_price
    @discounts = discounts
  end

end

class LinearDiscount
  attr_reader :discount_price, :quantity_threshold

  def initialize(discount_price, quantity_threshold)
    @discount_price = discount_price
    @quantity_threshold = quantity_threshold
  end
end

class BatchDiscount
  attr_reader :batch_threshold_trigger, :gets_free, :occurs

  def initialize(batch_threshold_trigger, gets_free, occurs)
    @batch_threshold_trigger = batch_threshold_trigger
    @gets_free = gets_free
    @occurs = occurs
  end

  
end
