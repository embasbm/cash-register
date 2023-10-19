class ProductsController < InheritedResources::Base
  before_action :authenticate_user!

  def index
    @stock_available = Product.all.any? { |p| p.amount > 0}
    super
  end

  private

  def product_params
    params.require(:product).permit(:code, :name, :price_cents)
  end

end
