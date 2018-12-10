require 'rails_helper'

RSpec.describe "Products_request", type: :request do
  describe "GET #show" do
    let(:category) { create(:taxonomy, name: "Category") }
    let!(:taxon) { create(:taxon, name: "Taxon", taxonomy: category, parent: category.root) }
    let!(:other_taxon) do
      create(:taxon, name: "other_taxon", taxonomy: category, parent: category.root)
    end
    let!(:product) { create(:product, taxons: [taxon], name: "Product", price: "23.45") }
    let!(:related_product) do
      create(:product, name: "related_product", price: "54.37", taxons: [taxon])
    end
    let!(:other_product) do
      create(:product, name: "other_product", price: "98.76", taxons: [other_taxon])
    end
    let!(:product_property) { create(:product_property, product: product, value: "type") }

    before do
      get potepan_product_url(product.id)
    end

    # 正常にレスポンスを返すこと
    it "responds successfully and 200 response" do
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
    # 正しいViewを返すこと
    it "show correct View" do
      expect(response).to render_template :show
    end
    # 商品が表示されていることを確認
    it "show templete products display" do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
      expect(response.body).to include product_property.property.presentation
      expect(response.body).to include product_property.value
      expect(response.body).to include related_product.name
      expect(response.body).to include related_product.display_price.to_s
      expect(response.body).not_to include other_product.name
      expect(response.body).not_to include other_product.display_price.to_s
    end
    # データが取得できていること
    it "assigns instance variables" do
      expect(assigns(:product)).to eq product
      expect(assigns(:product_properties)).to match_array product_property
    end
    # 関連した商品のデータが取得できていること
    it "assigns related_products" do
      expect(assigns(:related_products)).to include related_product
      expect(assigns(:related_products)).not_to include product
      expect(assigns(:related_products)).not_to include other_product
    end
  end
end
