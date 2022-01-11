require 'checkout'

RSpec.describe Checkout do
  describe 'Checkout' do
    # subject(:total) { checkout.total}
    let(:checkout) { Checkout.new }

    context 'when no offers apply' do
      before do
        checkout.scan("apple")
        checkout.scan("orance")
      end

      it 'returns the base price for the basket' do
        expect(total).to eq(30)
      end
    end
    
    
    context 'when apple bogoff applies' do
      before do
        
        checkout.scan("apple")
        checkout.scan("apple")
        checkout.total
        
      end

      it 'returns the base price for the basket' do
        expect(checkout.basket_total).to eq(10)
      end
    end

  end
end
