

class Db

  def initialize()
    @pricingRules = connectdb
  end

  def select(item)
    return @pricingRules[item]
  end
end


def connectdb

  pricing_rules = {
    
      "apple" => PricePolicy.new(10, BatchDiscount.new(2, 1, -1)), #bogoff
      "orange" => PricePolicy.new(20),
      "pear" => PricePolicy.new(15, BatchDiscount.new(2, 1, -1)), #bogoff
      "banana" => PricePolicy.new(30, PercentDiscount.new(50)),
      "pineapple" => PricePolicy.new(100, PercentDiscount.new(50)),
      "mango" => PricePolicy.new(200, BatchDiscount.new(3, 1, 1)),
      "rogue" => PricePolicy.new(30, RogueDiscount.new(50)), 
    }

    return pricing_rules
end

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