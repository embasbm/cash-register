require 'rails_helper'

RSpec.describe LineItem, type: :model do
  let!(:user) { create(:user)}
  let!(:cart) { create(:cart)}
  let!(:product) { create(:product)}

  let(:line_item) { create(:line_item)}

  it 'will have cart and product and quantity values' do
    expect(line_item.cart).to eq cart
    expect(line_item.product).to eq product
    expect(line_item.quantity).to eq 1
  end
end
