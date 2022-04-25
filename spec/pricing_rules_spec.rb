require "pricing_rules"

RSpec.describe PricingRules do
  describe "#unit_price" do
    it "fetches the unit price for the item" do
      pricing_rules = PricingRules.new("A" => {unit_price: 50})

      unit_price = pricing_rules.unit_price("A")

      expect(unit_price).to eq 50
    end
  end

  describe "#discount_price" do
    it "fetches the discount price for the item" do
      pricing_rules = PricingRules.new("A" => {discount_price: 130})

      discount_price = pricing_rules.discount_price("A")

      expect(discount_price).to eq 130
    end
  end

  describe "#discount_count" do
    it "fetches the discount count of the item" do
      pricing_rules = PricingRules.new("A" => {discount_count: 3})

      discount_count = pricing_rules.discount_count("A")
       
      expect(discount_count).to eq 3
    end
  end

  describe "#price_for" do
    it "calculates the price for a number of items" do

      pricing_rules = PricingRules.new(
        "A" => {unit_price: 50, discount_price: 130, discount_count: 3})

      price = pricing_rules.price_for("A", 3)

      expect(price).to eq 130
    end
  end

  describe "#has_dicount_price" do
    it "checks if an item has a discount price" do
      pricing_rules = PricingRules.new("A" => {discount_price: 130})
      
      has_discount = pricing_rules.has_discount_price("A")

      expect(has_discount).to be(true)
    end
  end
end
