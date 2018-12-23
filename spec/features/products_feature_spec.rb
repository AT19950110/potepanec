require 'rails_helper'

RSpec.feature "Products_feature", type: :feature do
  let!(:taxonomy) { create(:taxonomy, name: "Category") }
  let!(:taxon) do
    create(:taxon, name: "Taxon", taxonomy: taxonomy, parent: taxonomy.root)
  end
  let!(:other_taxon) do
    create(:taxon, name: "other_taxon",
                   taxonomy: taxonomy, parent: taxonomy.root)
  end

  let!(:product) { create(:product, name: "Product", price: "23.45", taxons: [taxon]) }

  let!(:related_products) do
    4.times.collect do |i|
      create(:product, name: "related_product#{i + 1}",
                       price: "#{rand(1.0..99.9).round(2)}",
                       taxons: [taxon])
    end
  end

  let!(:other_product) do
    create(:product, name: "other_product", price: "98.76", taxons: [other_taxon])
  end

  let!(:product_property) { create(:product_property, product: product, value: "type") }

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
    expect(page).to have_link '一覧ページへ戻る',
                              href: potepan_category_path(product.taxons.first.id)
  end

  scenario "should be able to visit related products" do
    visit potepan_product_path(product.id)
    # 同じ商品は表示しない
    expect(page).not_to have_selector ".productCaption h5", text: product.name
    expect(page).not_to have_selector ".productCaption h3", text: product.display_price
    # 関連しない商品は表示しない
    expect(page).not_to have_selector ".productCaption h5", text: other_product.name
    expect(page).not_to have_selector ".productCaption h3", text: other_product.display_price
    # 関連商品が表示される
    related_products.each do |related_product|
      expect(page).to have_selector ".productCaption h5", text: related_product.name
      expect(page).to have_selector ".productCaption h3", text: related_product.display_price
    end
  end
end
