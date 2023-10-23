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

  describe "before_create callback" do
    let!(:product) { create(:product) }
    let!(:line_item) { create(:line_item, product: product, cart: cart, quantity: 2) }

    it 'calculates the total price correctly' do
      cart.line_items << line_item
      cart.save
      expect(cart.reload.total_price).to eq(2*product.price_cents)
    end

    context 'line_items has not changed' do
      it 'will not call the #calculate_total_price' do
        expect(cart).not_to receive(:calculate_total_price)
        cart.save
      end
    end
  end

  describe '#settle_total_price' do
    before do
      ['Coffee', 'Strawberries', 'Green Tea'].map do |product_name|
        create(:product, name: product_name)
      end
    end

    subject { cart.settle_total_price! }

    ['Coffee', 'Strawberries', 'Green Tea'].map do |product_name|
      context "when one single #{product_name} in cart" do
        before { create(:line_item, cart: cart, product: Product.find_by_name(product_name), quantity: quantity) }

        let(:quantity) { product_name == 'Green Tea' ? 2 : 1 } 

        it 'cart total_amount will be the product value' do
          subject

          expect(cart.reload.total_price).to eq Product.find_by_name(product_name).price_cents
        end
      end

      context "when 4 #{product_name} item in cart" do
        let!(:line_item) { create(:line_item, cart: cart, product: Product.find_by_name(product_name), quantity: 4) }

        it 'cart total_amount will be the product value' do
          subject

          if product_name == 'Strawberries'
            expect(cart.reload.total_amount.to_s).to eq ('18.00') # [4 * 450] (450 is the new price when quantity 3 or more)
          elsif product_name == 'Coffee'
            expect(cart.reload.total_amount.to_s).to eq ('4.15') # [311 * 4 - 311 * 4 * 2/3] (311 is the product price)
          else # product_name == 'Green Tea'
            expect(cart.reload.total_amount.to_s).to eq ('9.33') # [(4-1) * 311] (311 is the product price)
          end
        end
      end
    end
  end
end
