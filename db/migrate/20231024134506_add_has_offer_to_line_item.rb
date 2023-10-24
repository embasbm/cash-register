class AddHasOfferToLineItem < ActiveRecord::Migration[7.0]
  def change
    add_column :line_items, :has_offer, :boolean, default: false
  end
end
