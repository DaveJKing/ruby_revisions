require 'spec_helper'
require 'checkoutkata'

RSpec.describe Checkout do
  describe '#total' do
    subject(:total) { checkout.total}
    let(:checkout) { Checkout.new() }
    
    
    
    
    context 'when no offers apply' do
      before do
        DB_VIEW = checkout.db_view
        checkout.scan(:apple)
        checkout.scan(:orange)
      end

      it 'returns the base price for the basket' do
        expect(total).to eq(30)
      end
    end
    
  end
end
