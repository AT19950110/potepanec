require 'rails_helper'

RSpec.feature "Categories_feature", type: :feature do
  let!(:taxonomy) { create(:taxonomy, name: "Category") }
  let!(:taxon) { create(:taxon, name: "Clothing", taxonomy: taxonomy, parent: taxonomy.root) }
  let!(:t_shirts) { create(:taxon, name: "T-Shirts", taxonomy: taxonomy, parent: taxon.root) }
  let!(:shirts) { create(:taxon, name: "Shirts", taxonomy: taxonomy, parent: t_shirts.root) }
  let!(:product) { create(:product, name: "Ruby on Rails T-Shirt", taxons: [t_shirts]) }

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
    expect(page).to have_selector ".panel-body", text: t_shirts.name
    expect(page).to have_selector ".panel-body", text: t_shirts.name
    expect(page).to have_selector ".productCaption h5", text: product.name
    expect(page).to have_selector ".productCaption h3", text: product.display_price
    expect(page).to have_link "Home", href: potepan_index_path
  end
  # カテゴリへのリンクを検証する
  scenario "should be able to visit other category" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_link taxon.name, href: potepan_category_path(taxon.id)
    expect(page).to have_link shirts.name, href: potepan_category_path(shirts.id)
  end
  # 商品詳細へのリンクを検証する
  scenario "should be able to visit products" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_link product.name, href: potepan_product_path(product.id)
  end
end
