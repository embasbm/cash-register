class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items, before_add: :calculate_total_price, before_remove: :calculate_total_price

  monetize :total_price, as: "total_amount"

  before_create :calculate_total_price, if: :line_items_changed?

  def settle_total_price!
    self.total_price = 0

    line_items.includes(:product).each do |li|
      if li.quantity >= 3
        case li.product.name
        when 'Strawberries'
          self.total_price += li.quantity * 450
        when 'Coffee'
          cost_of_all_coffees = li.quantity * li.product.price_cents
          cost_to_drop = cost_of_all_coffees * 2 / 3
          new_coffee_cost = cost_of_all_coffees - cost_to_drop
          self.total_price += new_coffee_cost
        when 'Green Tea'
          self.total_price += li.quantity * li.product.price_cents
          li.update(quantity: li.quantity * 2)
        else
          self.total_price += li.quantity * li.product.price_cents
        end
      else
        self.total_price += li.quantity * li.product.price_cents
        if li.product.name == 'Green Tea'
          li.update(quantity: li.quantity * 2)
        end
      end
    end

    save!
  end

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
