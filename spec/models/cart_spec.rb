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
  end
end
