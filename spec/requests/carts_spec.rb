require 'rails_helper'

RSpec.describe "Carts", type: :request do
  let!(:product) { create(:product, name: 'Foo') }
  let!(:user) { create(:user) }

  before {
    sign_in user
    allow(controller).to receive(:current_user).and_return(user)
  }

  describe "POST /add_to_cart" do
    let!(:cart) { create(:cart)}
    let(:params) {{ product_id: product.id }}
    subject { post "/carts/add_to_cart", params: params }

    it "redirects to root path" do
      subject

      expect(response).to redirect_to(root_path)
    end

    it "will create a new line item within the cart" do
      expect {
        subject
      }.to change(cart.line_items, :count).from(0).to(1)
    end

    context 'when cart already has the product' do
      before { cart.line_items.create(product: product, quantity: 10) }

      it 'will increase the quantity for this product within the line item' do
        expect {
          subject
        }.to change { cart.line_items.first.reload.quantity }.from(10).to(11)
      end
    end
  end
end
