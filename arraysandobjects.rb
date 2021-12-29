puts "running Checkout"

class LinearDiscount
  # puts "hello from initialise Linear Discount"

  attr_reader :discount_price ,:quantity
  def initialize(discount_price, quantity)
    @discount_price = discount_price
    @quantity = quantity
  end

  #discount price type is linear
  # ------------------------------------
  # def calculate_for(quantity)
  #   (quantity / @quantity).floor * @discount_price
  # end
end

class BatchDiscount
  attr_reader :batch_threshold_trigger, :gets_free, :occurs
  def initialize(batch_threshold_trigger, gets_free, occurs)
    
    # puts "hello from initialise Batch Discount"

    @batch_threshold_trigger = batch_threshold_trigger
    @gets_free = gets_free
    @occurs = occurs
  end

  #discount price type is linear
  # ------------------------------------
  # def calculate_for(quantity)
  #   (quantity / @quantity).floor * @discount_price
  # end
end

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

# Rules are a hash
RULES = {
  "A" => PricePolicy.new(50, LinearDiscount.new(20, 3)),
  "B" => PricePolicy.new(30, LinearDiscount.new(15, 2)),
  "C" => PricePolicy.new(20),
  "D" => PricePolicy.new(15),
  "E" => PricePolicy.new(30, BatchDiscount.new(2, 1, 1)),
  # Above buy 2 get 1 free , only one cycle
  "F" => PricePolicy.new(30, BatchDiscount.new(3, 2, -1)),
# Above buy 2 get 1 free , perpetual  i.e no limit

}
puts RULES
puts RULES.class

puts RULES.has_key?("A")
puts RULES.has_key?("X")

#user.extract!("email").values # ["john@email.com"]

# for number in RULES
#   print number
# end
puts RULES["F"]

x = RULES["F"]
y = x
puts "item base price : " + x.base_price.to_s
puts x.discounts[0].class.name
puts x.class.name

case x.discounts[0].class.name
when "LinearDiscount", "lineardiscount"
  puts "Linear Discount encountered"
  puts "Item is sold at " + x.base_price.to_s + " initially. then " + x.discounts[0].discount_price.to_s + " after quantity of " + x.discounts[0].quantity.to_s
when "BatchDiscount", "baychdiscount"
  puts "Batch Discount encountered"
  puts "Item is sold at " + x.base_price.to_s + " initially, then after " + x.discounts[0].batch_threshold_trigger.to_s + " item purchases buyer gets " + x.discounts[0].gets_free.to_s
  if x.discounts[0].occurs == -1
    puts "this discount cycles indefinitely !"
  else
    puts "this discount cycles " + x.discounts[0].occurs.to_s + " times(s) only"
  end
else
  puts "unknown discount policy"
end

# puts RULES["A"]

puts "end"
