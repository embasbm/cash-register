class ProductsController < InheritedResources::Base
  before_action :authenticate_user!

  def index
    @products = Product.all.select { |p| p.amount > 0 }
    super
  end

  private

  def product_params
    params.require(:product).permit(:code, :name, :price_cents)
  end

end
