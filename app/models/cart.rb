class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items, before_add: :calculate_total_price, before_remove: :calculate_total_price

  monetize :total_price, as: "total_amount"

  before_create :calculate_total_price, if: :line_items_changed?

  private

  def calculate_total_price(line_item = nil)
    if line_item
      self.total_price = total_price + (line_item.product.price_cents * line_item.quantity)
    else
      self.total_price = line_items.sum { |li| li.product.price_cents * li.quantity }
    end
  end

  def line_items_changed?
    persisted? && line_items_changed
  end
end
