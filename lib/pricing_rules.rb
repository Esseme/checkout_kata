class PricingRules 
  def initialize(rules)
    @rules = rules
  end

  def unit_price(item)
    @rules[item][:unit_price]
  end

  def discount_price(item)
    @rules[item][:discount_price]
  end

  def discount_count(item)
    @rules[item][:discount_count]
  end

  def price_for(item, count)
    count/discount_count(item) * discount_price(item) + count% discount_count(item) * unit_price(item) 
  end
end
