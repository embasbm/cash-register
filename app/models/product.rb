class Product < ApplicationRecord
  monetize :price_cents

  def self.ransackable_attributes(auth_object = nil)
    ["code", "created_at", "id", "name", "price_cents", "updated_at"]
  end
end
