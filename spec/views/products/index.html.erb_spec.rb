require 'rails_helper'

RSpec.describe "products/index", type: :view do
  context 'when stock available' do
    before do
      assign(:products, [
        create(:product, code: "Code1", name: "Product1", price_cents: 200, amount: 5),
        create(:product, code: "Code2", name: "Product2", price_cents: 150, amount: 0)
      ])
    end
  
    it "renders a list of products" do
      render

      within("#products") do
        expect(page).to have_selector("table")
        expect(page).to have_selector("th", text: "Code")
        expect(page).to have_selector("th", text: "Name")
        expect(page).to have_selector("th", text: "Price")
        expect(page).to have_selector("th", text: "Stock (Amount)")

        # Verify that only the product with a positive amount is displayed
        expect(page).to have_selector("td", text: "Code1")
        expect(page).to have_selector("td", text: "Product1")
        expect(page).to have_selector("td", text: "200")
        expect(page).to have_selector("td", text: "5")

        expect(page).not_to have_selector("td", text: "Code2")
        expect(page).not_to have_selector("td", text: "Product2")
        expect(page).not_to have_selector("td", text: "150")
        expect(page).not_to have_selector("td", text: "0")

        expect(rendered).not_to have_selector(".alert.alert-alert")
      end
    end
  end

  context 'when no stock available' do
    before { assign(:products, []) }

    it "displays a message when there are no products" do
      render
      within("#products") do
        expect(rendered).to have_selector(".alert.alert-alert")
        expect(rendered).to have_content("No products available for now")
      end
    end
  end
end
