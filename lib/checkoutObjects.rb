puts "Loading objects ....."

# class Checkout
#     attr_accessor  :loyaltycardno, :items, :basket_total
#     def initialize()
#       @items = Hash.new
#       @basket_total = 0
#     end

#     def scan(item,*loyaltyCardNoRef)
#       if item.downcase != "clubcard"
#         begin
#             check = RULES.fetch(item)
#         rescue => exception
#             # item is not in stock database, handle and report
#             puts "*** Item not in inventoty database - Inform shopper Item removed fom sale to be polite. ***"
#         else
#             # add an initialise to 0 if not existing
#             @items[item] ||= 0
#             # increment item count +1,
#             @items[item] += 1
#         end
#       end
#       self.loyaltycardno =loyaltyCardNoRef[0].to_s unless loyaltyCardNoRef.empty?
#     end

#     def total_up

#         # puts @items
#         for item,itemQuanityPurchased in @items

#             itemRule = RULES[item]
#             itemRuleDiscount = itemRule.discounts[0]

#             # puts itemRule.discounts[0].class.name

#             case itemRule.discounts[0].class.name
#             when "LinearDiscount", "lineardiscount"
#                 # Base price operates but discount price kicks in after quantity threshold

#                 if itemQuanityPurchased > itemRuleDiscount.quantity_threshold
#                     # "Discount threshold passed !"

#                     baseTotal = itemRule.base_price * (itemRuleDiscount.quantity_threshold )

#                     discountQty = itemQuanityPurchased - (itemRuleDiscount.quantity_threshold )
#                     discountTotal = discountQty * itemRuleDiscount.discount_price
#                     @basket_total += baseTotal + discountTotal

#                 else
#                     # "Discount threshold NOT reached !"
#                     @basket_total += itemQuanityPurchased * itemRule.base_price
#                 end
#             when "BatchDiscount", "batchdiscount"
#                 #  Buy n get y free, happens prefined times or perpetually
#                 puts "Batch discount item !"
#                 @basket_total += itemQuanityPurchased * itemRule.base_price
#             else
#                 puts "No discount"
#                 @basket_total += itemQuanityPurchased * itemRule.base_price
#             end
#          end
#     end
# end

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
  attr_reader :buys, :gets_free, :occurs

  def initialize(buys, gets_free, occurs)
    @buys = buys
    @gets_free = gets_free
    @occurs = occurs
  end
end

class PercentDiscount
  #  Buy n get y free, happens prefined times or perpetually
  attr_reader :percentile

  def initialize(percentile)
    @percentile = percentile
  end
end


# For system testing only
class RogueDiscount
    #  Buy n get y free, happens prefined times or perpetually
    attr_reader :percentile
  
    def initialize(percentile)
      @percentile = percentile
    end
  end
