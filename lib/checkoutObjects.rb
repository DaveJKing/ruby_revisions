
puts "Loading objects ....."
class PricePolicy
    attr_reader :base_price, :discounts
  
    def initialize(base_price, *discounts)
      @base_price = base_price
      @discounts = discounts
    end
  
    # def price_for(quantity)
    #   quantity * @base_price - discount_for(quantity)
    # end
  
    # def discount_for(quantity)
    #   @discounts.inject(0) do |mem, discount|
    #     mem + discount.calculate_for(quantity)
    #   end
    # end
  end


class LinearDiscount
    # puts "hello from initialise Linear Discount"
  
    attr_reader :discount_price ,:quantity
    def initialize(discount_price, quantity)
      @discount_price = discount_price
      @quantity = quantity
    end
  
  end

class BatchDiscount
attr_reader :batch_threshold_trigger, :gets_free, :occurs
def initialize(batch_threshold_trigger, gets_free, occurs)
    
    # puts "hello from initialise Batch Discount"

    @batch_threshold_trigger = batch_threshold_trigger
    @gets_free = gets_free
    @occurs = occurs
end
end