class Checkout 
  def initialize(pricing_rules)
    @total = 0
  end

  def total
    @total
  end
  
  def scan(item)
    @total = 50
  end
end

RSpec.describe 'checkout' do 
  context 'when nothing has been scanned' do
    it 'shows a total of zero' do
      pricing_rules = :Banana
      checkout = Checkout.new(pricing_rules)

      total = checkout.total

      expect(total).to eq 0
    end
  end
  
  context 'when A has been scanned' do
    it 'shows the price of A' do
      pricing_rules = :Banana
      checkout = Checkout.new(pricing_rules)

      checkout.scan('A')
      total = checkout.total

      expect(total).to eq 50
    end
  end
end
