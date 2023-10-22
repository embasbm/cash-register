# spec/controllers/carts_controller_spec.rb

require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product, name: 'Foo') }

  before do
    sign_in user
  end

  describe 'POST #add_to_cart' do
    subject { post :add_to_cart, params: { product_id: product.id } }

    context 'when adding a product to the cart' do
      it 'increases the line item quantity when the product is already in the cart' do
        cart = create(:cart, user: user)
        line_item = create(:line_item, cart: cart, product: product)

        subject

        expect(line_item.reload.quantity).to eq(2)
        expect(flash[:success]).to eq('Product quantity added to the cart successfully')
      end

      it 'creates a new line item when the product is not in the cart' do
        subject

        cart = user.cart.reload
        expect(cart.line_items.count).to eq(1)
        expect(cart.line_items.first.product).to eq(product)
        expect(cart.line_items.first.quantity).to eq(1)
        expect(flash[:success]).to eq('Product added to the cart successfully')
      end

      it 'decreases the product amount' do
        subject

        expect(product.reload.amount).to eq(9)
      end

      it 'redirects to the root path' do
        subject

        expect(response).to redirect_to(root_path)
      end

      context 'when product runs out of stock' do
        before { product.update(amount: 0) }

        it 'handles exceptions and sets flash[:error] on error' do
          subject
  
          expect(flash[:error]).to eq('Validation failed: Amount must be greater than or equal to 0')
        end
      end
    end
  end

  describe '#destroy' do
    let!(:cart) { create(:cart, user: user) }
    let!(:line_item) { create(:line_item, cart: cart, product: product) }

    it 'will update product amount/stock' do
      delete :destroy, params: { id: cart.id }

      expect(product.reload.amount).to eq(11)
      expect { line_item.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect { cart.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#quantity_to_add' do
    ['Coffee', 'Strawberries', 'Green Tea'].map do |product_name|
      if product_name == 'Green Tea'
        context 'when the product name is "Green Tea"' do
          it 'returns 2' do
            controller.instance_variable_set(:@product, Product.new(name: 'Green Tea'))
            expect(controller.send(:quantity_to_add)).to eq(2)
          end
        end
      else
        context 'when the product name is not "Green Tea"' do
          it 'returns 1' do
            controller.instance_variable_set(:@product, Product.new(name: 'Black Tea'))
            expect(controller.send(:quantity_to_add)).to eq(1)
          end
        end    
      end
    end
  end
end
