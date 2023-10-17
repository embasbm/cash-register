require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { create(:cart)}

  it 'will have total_amount column as Money class' do
    expect(cart.total_amount.class).to eq Money
    expect(cart.total_amount.to_s).to eq '1.30'
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
end
