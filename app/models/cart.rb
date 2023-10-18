class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items

  monetize :total_price, as: "total_amount"

  before_save :calculate_total_price

  private

  def calculate_total_price
    self.total_price = line_items.sum { |line_item| line_item.product.price_cents * line_item.quantity }
  end
end
