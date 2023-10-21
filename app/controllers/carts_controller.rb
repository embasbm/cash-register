class CartsController < ApplicationController
  before_action :set_cart, only: :add_to_cart
  before_action :set_product, only: [:add_to_cart, :update_product_amount]

  def add_to_cart
    line_item = @cart.line_items.find_by(product: @product)
    if line_item
      line_item.update!(quantity: line_item.quantity + 1)
      flash[:success] = 'Product quantity added to the cart successfully'
    else
      @cart.line_items.create!(product: @product, quantity: 1)
      flash[:success] = 'Product added to the cart successfully'
    end
    update_product_amount
  rescue => e
    flash[:success].clear
    flash[:error] = e.message
  ensure
    @cart.settle_total_price!
    redirect_to root_path
  end

  private
  def set_cart
    @cart = current_user.cart.present? ? current_user.cart : Cart.create!(user: current_user, total_price: 0)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def update_product_amount
    @product.amount -= 1
    @product.save!
  end

  def carts_params
    params.require(:cart).permit(:product_id)
  end
end
