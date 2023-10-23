class AddPriceCentsToLineItem < ActiveRecord::Migration[7.0]
  def change
    add_column :line_items, :price_cents, :integer
  end
end
