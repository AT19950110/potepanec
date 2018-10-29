require 'rails_helper'

RSpec.feature "SiteLayouts", type: :feature do
  scenario "View products show page" do
    product = FactoryBot.create(:product)
    visit potepan_product_path(product.id)
    expect(page).to have_current_path "/potepan/products/#{product.id}"
    expect(page).to have_title "Single Product - BIGBAG Store"
  end
end
