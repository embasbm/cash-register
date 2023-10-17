class Product < ApplicationRecord
  monetize :price_cents
  validates_numericality_of :amount,
    greater_than_or_equal_to: 1, allow_nil: false

  def self.ransackable_attributes(auth_object = nil)
    ["code", "created_at", "id", "name", "price_cents", "updated_at"]
  end
end
