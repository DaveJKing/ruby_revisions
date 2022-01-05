puts "Methods objects ....."

def showDiscountStrategy(itemRule, debug)
    if debug
      itemRuleDiscount = itemRule.discounts[0] # This is the discount strategy if one exists.
  
      case itemRule.discounts[0].class.name
      when "LinearDiscount", "lineardiscount"
        puts "Linear Discount encountered"
        puts "Item is sold at " + itemRule.base_price.to_s + " initially. then " + itemRuleDiscount.discount_price.to_s + " after quantity of " + itemRuleDiscount.quantity_threshold.to_s
      when "BatchDiscount", "batchdiscount"
        puts "Batch Discount encountered"
        puts "Item is sold at " + itemRule.base_price.to_s + " initially, then after " + itemRuleDiscount.batch_threshold_trigger.to_s + " item purchases buyer gets " + itemRuleDiscount.gets_free.to_s
        if itemRuleDiscount.occurs == -1
          puts "this discount cycles indefinitely !"
        else
          puts "this discount cycles " + itemRuleDiscount.occurs.to_s + " times(s) only"
        end
      else
        puts "unknown discount policy"
      end
    end
  end