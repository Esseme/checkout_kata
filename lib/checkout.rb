class CheckOut
  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @items_count = Hash.new(0) 
  end
  
  def scan(item)
    @items_count[item] += 1
  end

  def total
    @items_count.inject(0) do |total, (item, count)|
      if item == 'B' || item == 'A'
        total += @pricing_rules.price_for(item, count)
      else
        total += count*@pricing_rules.unit_price(item)
      end
    end
  end
end
