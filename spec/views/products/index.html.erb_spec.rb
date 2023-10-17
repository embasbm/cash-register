require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        code: "Code",
        name: "Name",
        price_cents: 2,
        amount: 10
      ),
      Product.create!(
        code: "Code",
        name: "Name",
        price_cents: 2,
        amount: 10
      )
    ])
  end

  it "renders a list of products" do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Code".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
