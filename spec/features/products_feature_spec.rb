require 'rails_helper'

RSpec.feature "Products_feature", type: :feature do
  let!(:product) { create(:product) }
  let!(:product_property) { create(:product_property, product: product, value: "type") }

  include ProductsHelper

  scenario "View show page" do
    visit potepan_product_path(product.id)
    expect(page).to have_current_path potepan_product_path(product.id)
    expect(page).to have_title "#{product.name} - BIGBAG Store"
    expect(page).to have_selector ".page-title h2", text: product.name
    expect(page).to have_selector ".col-xs-6 h2", text: product.name
    expect(page).to have_selector ".col-xs-6 h2", text: product.name
    expect(page).to have_selector ".media-body h2", text: product.name
    expect(page).to have_selector ".media-body h3", text: product.display_price
    expect(page).to have_selector ".media-body p", text: product.description
    expect(page).to have_selector ".tab-content li", text:
        "#{product_property.property.presentation} : #{product_property.value}"
    expect(page).to have_link 'Home', href: potepan_index_path
  end
  # 関連商品に選択された商品が表示されないことを検証
  scenario "should be able to visit related products" do
    visit potepan_product_path(product.id)
    expect(page).not_to have_selector ".productCaption h5", text: product.name
    expect(page).not_to have_selector ".productCaption h3", text: product.display_price
  end
end
