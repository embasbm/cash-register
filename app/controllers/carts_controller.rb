class CartsController < ApplicationController
  before_action :set_cart, only: :add_to_cart

  def add_to_cart
    product = Product.find(params[:product_id])
    line_item = @cart.line_items.find_by(product: product)
    if line_item
      line_item.update!(quantity: line_item.quantity + 1)
      flash[:success] = 'Product quantity added to the cart successfully'
    else
      @cart.line_items.create!(product: product, quantity: 1)
      flash[:success] = 'Product added to the cart successfully'
    end

    # @cart.settle_total_price!

    redirect_to root_path
  end

  private
  def set_cart
    @cart = current_user.cart.present? ? current_user.cart : Cart.create!(user: current_user, total_price: 0)
  end

  def carts_params
    params.require(:cart).permit(:product_id)
  end
end
