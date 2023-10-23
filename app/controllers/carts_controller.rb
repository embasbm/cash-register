class CartsController < ApplicationController
  before_action :set_cart, only: [:add_to_cart, :destroy]
  before_action :set_product, only: [:add_to_cart, :update_product_amount]

  def add_to_cart
    line_item = @cart.line_items.find_by(product: @product)
    amont_to_remove_from_product = quantity_to_add
    if line_item
      line_item.update!(quantity: line_item.quantity + quantity_to_add)
      flash[:success] = 'Product quantity added to the cart successfully'
    else
      @cart.line_items.create!(product: @product, quantity: quantity_to_add)
      flash[:success] = 'Product added to the cart successfully'
    end
    update_product_amount(amont_to_remove_from_product)
  rescue => e
    flash[:success].clear
    flash[:error] = e.message
  ensure
    @cart.settle_total_price!
    redirect_to root_path
  end

  def destroy
    @cart.line_items.map do |line_item|
      line_item.product.amount += line_item.quantity
      line_item.product.save
    end

    @cart.destroy

    flash[:success] = 'Basket emptied successfully'

    redirect_to root_path
  end

  private

  def quantity_to_add
    return 2 if @product&.name == 'Green Tea' && @cart&.line_items&.blank?
    1
  end

  def set_cart
    @cart = current_user.cart.present? ? current_user.cart : Cart.create!(user: current_user, total_price: 0)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def update_product_amount(amount)
    @product.amount -= amount
    @product.save!
  end

  def carts_params
    params.require(:cart).permit(:product_id)
  end
end
