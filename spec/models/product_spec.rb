require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create(:product)}

  it 'will have price column as Money class' do
    expect(product.price.class).to eq Money
  end

  context 'when price is not integer' do
    let(:product) { Product.new(price: 'foo', amount: 3)}

    it 'will not be valid' do
      expect(product).not_to be_valid
    end
  end

  context 'when amount is blank' do
    let(:product) { Product.new(amount: nil)}

    it 'will not be valid' do
      expect(product).not_to be_valid
    end
  end
end
