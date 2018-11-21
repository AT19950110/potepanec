require 'rails_helper'

RSpec.feature "Categories_feature", type: :feature do
  let!(:taxonomies) { create(:taxonomy, name: "Category") }
  let!(:taxon) { taxonomies.root.children.create(name: "Clothing") }
  let!(:t_shirts) { taxon.root.children.create(name: "T-Shirts") }
  let!(:shirts) { t_shirts.children.create(name: "Shirts") }
  let!(:product) { create(:product, name: "Ruby on Rails T-Shirt", taxons: [t_shirts]) }

  scenario "View category show page" do
    # ページを開く
    visit potepan_categories_path(taxon_id: taxonomies.root.id)
    # 現在のパスが指定されたパスであることを検証する
    expect(page).to have_current_path "/potepan/categories/#{taxonomies.root.id}"
    # HTML要素の検証
    expect(page).to have_title "#{taxonomies.root.name} - BIGBAG Store"
    expect(page).to have_selector ".page-title h2", text: "category"
    expect(page).to have_selector ".col-xs-6 .breadcrumb", text: "Home category"
    expect(page).to have_selector ".panel-heading", text: taxonomies.name
    expect(page).to have_selector ".panel-body", text: taxon.name
    expect(page).to have_selector ".panel-body", text: t_shirts.name
    expect(page).to have_selector ".panel-body", text: t_shirts.name
    product = Spree::Product.find_by(name: "Ruby on Rails T-Shirt")
    expect(page).to have_selector ".productCaption h5", text: product.name
    expect(page).to have_selector ".productCaption h3", text: product.display_price
    expect(page).to have_link "Home", href: potepan_index_path
  end
  # カテゴリへのリンクを検証する
  scenario "should be able to visit other category" do
    visit potepan_categories_path(taxon_id: taxonomies.root.id)
    click_link "Clothing", href: taxon.id
    click_link "Shirts", href: shirts.id
  end
  # 商品詳細へのリンクを検証する
  scenario "should be able to visit products" do
    visit potepan_categories_path(taxon_id: taxonomies.root.id)
    expect(page).to have_link product.name, href: potepan_product_path(product.id)
  end
end
