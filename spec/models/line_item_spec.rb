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

  describe '#set_line_cost!' do
    context 'when Strawberries product' do
      let!(:strawberries) { create(:product, code: 'SR1', name: 'Green Tea') }

      context 'and 3 items in basket' do
        let!(:strawberries_line_item) { create(:line_item, quantity: 3, product: strawberries) }

        it 'will set line price_cents to 3 * class constant STRAWBERRY_OFFER_PRICE ' do
          strawberries_line_item.set_line_cost!

          strawberries_line_item.reload

          expect(strawberries_line_item.price_cents).to eq(3 * LineItem::STRAWBERRY_OFFER_PRICE)
          expect(strawberries_line_item.has_offer).to be(true)
        end
      end
    end

    context 'when Coffee product' do
      let!(:coffee) { create(:product, code: 'CF1', name: 'Green Tea', price_cents: 300) }

      context 'and 3 items in basket' do
        let!(:coffee_line_item) { create(:line_item, quantity: 3, product: coffee) }

        it 'will drop all coffees price by 2/3' do
          coffee_line_item.set_line_cost!

          coffee_line_item.reload

          expect(coffee_line_item.price_cents).to eq 600
          expect(coffee_line_item.has_offer).to be(true)
        end
      end
    end

    context 'when Green Tea product' do
      let!(:green_tea) { create(:product, code: 'GR1', name: 'Green Tea', price_cents: 300) }

      context 'and items count is 2' do
        let!(:green_tea_line_item) { create(:line_item, quantity: 2, product: green_tea, has_offer: true) }

        it 'will apply the buy-one-get-one-free (because we already do that at cart level)' do
          green_tea_line_item.set_line_cost!

          green_tea_line_item.reload

          expect(green_tea_line_item.has_offer).to be(true)
        end
      end

      context 'and items count is distinct more than 2' do
        let!(:green_tea_line_item) { create(:line_item, quantity: 3, product: green_tea, has_offer: true) }

        it 'will not apply the buy-one-get-one-free (because we already do that at cart level)' do
          green_tea_line_item.set_line_cost!

          green_tea_line_item.reload

          expect(green_tea_line_item.price_cents).to be(900)
          expect(green_tea_line_item.has_offer).to be(false)
        end
      end
    end
  end
end
