class ProductsController < InheritedResources::Base

  private

  def product_params
    params.require(:product).permit(:code, :name, :price_cents)
  end

end
