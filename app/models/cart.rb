class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy

  monetize :total_price, as: "total_amount"

  def settle_total_price!
    line_items.each { |li| li.set_line_cost! }
    check_green_tea_rule
    update!(total_price: line_items.sum(:price_cents))
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "total_price", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["line_items", "user"]
  end

  private

  def check_green_tea_rule
    if line_items.count == 1 && line_items.first.product.name == 'Green Tea' && line_items.first.quantity == 1
      line_items.first.update(quantity: 2, has_offer: true)
      line_items.first.product.remove_stock!
    elsif line_items.count > 1 && line_items.any? {|li| li.product.name == 'Green Tea' }
      green_tea_line = line_items.find { |li| li.product.name == 'Green Tea' }
      if green_tea_line.has_offer
        green_tea_line.update(quantity: 1, has_offer: false)
        green_tea_line.product.add_stock!
      end
      green_tea_line.set_line_cost!
    end
  end

  def line_items_changed?
    persisted? && line_items_changed
  end
end
