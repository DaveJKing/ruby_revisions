puts "running Checkout"

class LinearDiscount
  def initialize(discount_price, quantity)
    @discount_price = discount_price
    @quantity = quantity
    puts "hello from initialise Linear Discount"
  end

  #discount price type is linear
  # ------------------------------------
  # def calculate_for(quantity)
  #   (quantity / @quantity).floor * @discount_price
  # end
end

class BatchDiscount
  def initialize(batch_threshold_trigger, gets_free, occurs)
    puts "hello from initialise Batch Discount"

    @batch_threshold_trigger = batch_threshold_trigger,
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
  "F" => PricePolicy.new(30, BatchDiscount.new(2, 1, -1)),
  # Above buy 2 get 1 free , perpetual  i.e no limit

}
puts RULES
puts RULES.class

puts RULES.has_key?("A")
puts RULES.has_key?("X")

puts "end"
