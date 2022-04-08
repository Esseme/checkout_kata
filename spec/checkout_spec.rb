require 'checkout'
require 'pricing_rules'

RSpec.describe 'checkout' do
  context 'when nothing has been scanned' do
    it 'shows total of zero' do
      pricing_rules = :Rule
      checkout = CheckOut.new(pricing_rules)
      total = checkout.total

      expect(total).to eq 0
    end
  end

  context 'when A has been scanned' do 
    it 'shows the price of A' do
      pricing_rules = PricingRules.new("A" => {unit_price: 50, discount_price: 130, discount_count: 3})
      checkout = CheckOut.new(pricing_rules)
      checkout.scan('A')
      total = checkout.total

      expect(total).to eq 50
    end
  end

  context 'when B has been scanned' do
    it 'shows the price of B' do
      pricing_rules = PricingRules.new("B" => {unit_price: 30, discount_price: 45, discount_count: 2})
      checkout = CheckOut.new(pricing_rules)
      checkout.scan('B')
      total = checkout.total

      expect(total).to eq 30
    end
  end

  context 'when C has been scanned' do 
    it 'shows the price of C' do
      pricing_rules = PricingRules.new("C" => {unit_price: 20})
      checkout = CheckOut.new(pricing_rules)
      checkout.scan('C')
      total = checkout.total

      expect(total).to eq 20
    end
  end

  context 'when B, A and then D have been scanned' do
    it 'shows the total price of B, A and D' do
      pricing_rules = PricingRules.new(
        "B" => {unit_price: 30, discount_price: 45, discount_count: 2},
        "A" => {unit_price: 50, discount_price: 130, discount_count: 3},
        "D" => {unit_price: 15}
      )
      checkout = CheckOut.new(pricing_rules)

      checkout.scan('B')
      checkout.scan('A')
      checkout.scan('D')
      total = checkout.total

      expect(total).to eq 95
    end
  end

  context 'when D has been scanned' do 
    it 'shows the price of D' do
      pricing_rules = PricingRules.new("D" => {unit_price: 15})
      checkout = CheckOut.new(pricing_rules)
      checkout.scan('D')
      total = checkout.total

      expect(total).to eq 15
    end
  end

  context 'when B, A and another B has been scanned' do
    it 'shows the total discounted price of B plus price of A' do
      pricing_rules = PricingRules.new(
        "B" => {unit_price: 30, discount_price: 45, discount_count: 2},
        "A" => {unit_price: 50, discount_price: 130, discount_count: 3},
        "D" => {unit_price: 15}
      )
      checkout = CheckOut.new(pricing_rules)

      checkout.scan('B')
      checkout.scan('A')
      checkout.scan('B')
      total = checkout.total

      expect(total).to eq 95
    end
  end

  context 'when A, A, and another A have been scanned' do
    it 'shows the total discounted price of three A items' do
      pricing_rules = PricingRules.new(
        "A" => {unit_price: 50, discount_price: 130, discount_count: 3})
      checkout = CheckOut.new(pricing_rules)

      checkout.scan('A')
      checkout.scan('A')
      checkout.scan('A')
      total = checkout.total

      expect(total).to eq 130
    end
  end
end
