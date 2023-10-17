FactoryBot.define do
  factory :line_item do
    cart { Cart.first }
    product { Product.first }
    quantity { 1 }
  end
end
