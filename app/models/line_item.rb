class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def self.ransackable_attributes(auth_object = nil)
    ["cart_id", "created_at", "id", "product_id", "quantity", "updated_at"]
  end
end
