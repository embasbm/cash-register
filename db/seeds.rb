if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  User.create!(email: 'user@example.com', password: 'password', password_confirmation: 'password')
  Product.create!(code: "GR1", name: "Green Tea", price_cents: 311, amount: 10)
  Product.create!(code: "SR1", name: "Strawberries", price_cents: 500, amount: 10)
  Product.create!(code: "CF1", name: "Coffee", price_cents: 1123, amount: 10)
end
