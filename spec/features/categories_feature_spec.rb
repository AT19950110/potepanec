require 'rails_helper'

RSpec.feature "Categories_feature", type: :feature do
  let!(:taxonomy) { create(:taxonomy, name: "Category") }
  let!(:taxon) { create(:taxon, name: "Clothing", taxonomy: taxonomy, parent: taxonomy.root) }
  let!(:bag) { create(:taxon, name: "bag", taxonomy: taxonomy, parent: taxonomy.root) }
  let!(:shirts) { create(:taxon, name: "Shirts", taxonomy: taxonomy, parent: taxon) }
  let!(:product) do
    create(:product, name: "Ruby on Rails T-Shirt", price: "23.45", taxons: [shirts])
  end
  let!(:other_product) do
    create(:product, name: "other-bag", price: "98.76", taxons: [bag])
  end

  scenario "View category show page" do
    # ページを開く
    visit potepan_category_path(taxonomy.root.id)
    # 現在のパスが指定されたパスであることを検証する
    expect(current_path).to eq potepan_category_path(taxonomy.root.id)
    # HTML要素の検証
    expect(page).to have_title "#{taxonomy.root.name} - BIGBAG Store"
    expect(page).to have_selector ".page-title h2", text: "category"
    expect(page).to have_selector ".col-xs-6 .breadcrumb", text: "Home category"
    expect(page).to have_selector ".panel-heading", text: taxonomy.name
    expect(page).to have_selector ".panel-body", text: taxon.name
    expect(page).to have_selector ".panel-body", text: bag.name
    expect(page).to have_selector ".panel-body", text: shirts.name
    expect(page).to have_selector ".productCaption h5", text: product.name
    expect(page).to have_selector ".productCaption h3", text: product.display_price
    expect(page).to have_link "Home", href: potepan_index_path
  end

  # 各カテゴリの商品が表示されることを検証
  scenario "Products for each category are displayed" do
    visit potepan_category_path(bag.id)
    expect(current_path).to eq potepan_category_path(bag.id)
    # HTML要素の検証
    expect(page).to have_title "#{bag.name} - BIGBAG Store"
    expect(page).not_to have_selector ".page-title h2", text: "clothing"
    expect(page).to have_selector ".page-title h2", text: "bag"
    expect(page).not_to have_selector ".productCaption h5", text: product.name
    expect(page).to have_selector ".productCaption h5", text: other_product.name
    expect(page).not_to have_selector ".productCaption h3", text: product.display_price
    expect(page).to have_selector ".productCaption h3", text: other_product.display_price
  end

  # カテゴリへのリンクを検証する
  scenario "should be able to visit other category" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_link bag.name, href: potepan_category_path(bag.id)
    expect(page).to have_link shirts.name, href: potepan_category_path(shirts.id)
  end
  # 商品詳細へのリンクを検証する
  scenario "should be able to visit products" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_link product.name, href: potepan_product_path(product.id)
  end
end
