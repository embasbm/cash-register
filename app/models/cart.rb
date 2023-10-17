class Cart < ApplicationRecord
  has_many :line_items

  monetize :total_price, as: "total_amount"

  validates_numericality_of :total_price,
    greater_than_or_equal_to: 1, allow_nil: false
end
