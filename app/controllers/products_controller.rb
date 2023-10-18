class ProductsController < InheritedResources::Base
  before_action :authenticate_user!

  private

  def product_params
    params.require(:product).permit(:code, :name, :price_cents)
  end

end
