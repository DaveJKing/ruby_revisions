require 'checkout'

RSpec.describe Checkout do
  describe 'Checkout' do
    subject(:total) { checkout.total}
    let(:checkout) { Checkout.new }

    context 'when no offers apply' do
      before do
        checkout.scan("apple")
        checkout.scan("orange")
        checkout.totalUp
      end

      it 'returns the discounted price for the basket' do
        expect(checkout.basket_discounted_total).to eq(30)
      end

      it 'returns the NON discounted price for the basket' do
        expect(checkout.basket_non_discounted_total).to eq(30)
      end
    end
    
    # ***********************************************

    context 'when apple bogoff applies' do
      before do
        
        2.times { checkout.scan("apple") }
        checkout.totalUp
        
      end

      it 'returns the base price for the basket' do
        expect(checkout.basket_discounted_total).to eq(10)
      end

      context 'and there are other items' do
        before do
          checkout.scan("orange")
          checkout.totalUp
        end

        it 'returns the correctly discounted price for the basket' do
          expect(checkout.basket_discounted_total).to eq(30)
        end

        it 'returns the correctly NON discounted price for the basket' do
          expect(checkout.basket_non_discounted_total).to eq(40)
        end
      end
    end

    # ***********************************************

    context 'when a two for 1 applies on pears' do
      before do
        checkout.scan("pear")
        checkout.scan("pear")
        checkout.totalUp
      end

      

      it 'returns the discounted price for the basket' do
        expect(checkout.basket_discounted_total).to eq(15)
      end

      context 'and there are other discounted items' do
        before do
          checkout.scan("banana")
          checkout.totalUp
        end

       

        it 'returns the discounted price for the basket' do
          expect(checkout.basket_discounted_total).to eq(30)
        end
      end
    end

    # ***********************************************

    context 'when a half price offer applies on bananas' do
      before do
        checkout.scan("banana")
        checkout.totalUp
      end

      it 'returns the discounted price for the basket' do
        
        expect(checkout.basket_discounted_total).to eq(15)
      end
    end

    # ***********************************************

    context 'when a half price offer applies on pineapples restricted to 1 per customer' do
      before do
        checkout.scan("pineapple")
        checkout.scan("pineapple")
        checkout.totalUp
      end

      it 'returns the discounted price for the basket' do
        
        expect(checkout.basket_discounted_total).to eq(150)
        # This is right below
        # expect(checkout.basket_discounted_total).to eq(150)
      end
    end


    # context 'when a buy 3 get 1 free offer applies to mangos' do
    #   before do
    #     4.times { checkout.scan("mango") }
    #     checkout.totalUp

    #   end

    #   it 'returns the discounted price for the basket' do
    #     # pending 'You need to write the code to satisfy this test'
    #     expect(checkout.basket_discounted_total).to eq(600)
    #   end
    # end
  
  end
end
