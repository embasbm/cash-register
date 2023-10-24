require 'rails_helper'

RSpec.describe Cart, type: :model do
  let!(:user) { create(:user)}
  let(:cart) { create(:cart)}

  it 'will have total_amount column as Money class' do
    expect(cart.total_amount.class).to eq Money
    expect(cart.total_amount.to_s).to eq '0.00'
  end

  context 'when total_amount is not integer' do
    let(:cart) { Cart.new(total_amount: 'foo')}

    it 'will not be valid' do
      expect(cart).not_to be_valid
    end
  end

  context 'when total_amount is zero' do
    let(:cart) { Cart.new(total_amount: 0)}

    it 'will not be valid' do
      expect(cart).not_to be_valid
    end
  end

  describe "associations" do
    it 'belongs to a user' do
      cart = Cart.reflect_on_association(:user)
      expect(cart.macro).to eq(:belongs_to)
    end

    it 'should have many line_items' do
      cart = Cart.reflect_on_association(:line_items)
      expect(cart.macro).to eq(:has_many)
    end
  end

  describe '#settle_total_price!' do
    let!(:product) { create(:product) }
    let!(:line_item) { create(:line_item, product: product, cart: cart, quantity: 2) }

    it 'will execute set_line_cost instance method on each line item' do
      cart.settle_total_price! do
        expect(line_item).to receive(:set_line_cost!)
      end
    end
  end

  describe '#check_green_tea_rule' do
    context 'when cart has only one green tea item' do
      let!(:green_tea) { create(:product, name: 'Green Tea') }
      let!(:green_tea_line) { create(:line_item, product: green_tea, cart: cart, quantity: 1) }

      it 'will apply the green tea offer buy-one-get-one-free' do
        cart.send(:check_green_tea_rule) do
          expect { green_tea_line.quantity }.to change from(1).to(2)
          expect(green_tea_line.reload.has_offer).to be(true)
        end
      end

      context 'when another product added to one single green tea item' do
        let!(:strawberries) { create(:product, name: 'Strawberries') }
        let!(:green_tea_line) { create(:line_item, product: green_tea, cart: cart, quantity: 1) }
  
        it 'will remove green tea offer' do
          cart.send(:check_green_tea_rule) do
            expect { green_tea_line.quantity }.to change from(2).to(1)
            expect(green_tea.has_offer).to be(false)
          end
        end
      end
    end
  end
end
