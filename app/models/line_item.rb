class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  
  monetize :price_cents

  STRAWBERRY_OFFER_PRICE = 450
  COFEE_DROPPED_PRICE = 2 / 3.0

  def set_line_cost!
    price_to_apply = product.price_cents * quantity
    has_offer = self.has_offer
    case product.code
    when 'SR1'
      if quantity >= 3
        price_to_apply = STRAWBERRY_OFFER_PRICE * quantity 
        has_offer = true
      end
    when 'CF1'
      if quantity >= 3
        price_to_apply = quantity * product.price_cents * COFEE_DROPPED_PRICE
        has_offer = true
      end
    when 'GR1'
      has_offer = false if quantity != 2
    end

    update!(price_cents: price_to_apply, has_offer: has_offer)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["cart_id", "created_at", "id", "product_id", "quantity", "updated_at"]
  end
end
