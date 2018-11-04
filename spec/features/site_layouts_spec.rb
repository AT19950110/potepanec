require 'rails_helper'

RSpec.feature "SiteLayouts", type: :feature do
  let(:product) { create(:product) }

  scenario "View products show page" do
    visit potepan_product_path(product.id)
    expect(page).to have_current_path "/potepan/products/#{product.id}"
    expect(page).to have_title "#{product.name} - BIGBAG Store"
  end
end
