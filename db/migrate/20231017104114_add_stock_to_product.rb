class AddStockToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :amount, :integer
  end
end
