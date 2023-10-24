class Product < ApplicationRecord
  has_many :line_items

  monetize :price_cents
  validates_numericality_of :amount, greater_than_or_equal_to: 0, allow_nil: false

  def remove_stock!
    self.amount -= 1
    save!
  end

  def add_stock!
    self.amount += 1
    save!
  end

  def self.ransackable_attributes(auth_object = nil)
    ["code", "created_at", "id", "name", "price_cents", "updated_at", "amount"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["line_items"]
  end
end
