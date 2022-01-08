
def connectdb

pricing_rules = {
  
    "apple" => PricePolicy.new(10, BatchDiscount.new(2, 1, -1)), #bogoff
    "orange" => PricePolicy.new(20),
    "pear" => PricePolicy.new(15),
    "banana" => PricePolicy.new(30, PercentDiscount.new(50)),
    "pineapple" => PricePolicy.new(100, BatchDiscount.new(2, 1, 1)),
    "mango" => PricePolicy.new(200, BatchDiscount.new(3, 1, 1)),
    "rogue" => PricePolicy.new(30, RogueDiscount.new(50)), 
  }

  return pricing_rules
end