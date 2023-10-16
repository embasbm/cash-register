ActiveAdmin.register Product do
  permit_params :code, :name, :price_cents
end
