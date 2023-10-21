ActiveAdmin.register Cart do
  permit_params :code, :name, :price_cents, :amount
end
