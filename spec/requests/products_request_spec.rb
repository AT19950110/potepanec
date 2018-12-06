require 'rails_helper'

RSpec.describe "Products_request", type: :request do
  describe "GET #show" do
    let!(:product) { create(:product) }
    let!(:product_property) { create(:product_property, product: product, value: "type") }

    include ProductsHelper

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
    end
    # データが取得できていること
    it "assigns instance variables" do
      expect(assigns(:product)).to eq product
      expect(assigns(:product_properties)).to match_array product_property
    end
    # 関連した商品のデータが取得できていること
    it "assigns related_products" do
      #expect(related_uniq_products_array(product)).not_to include product
    end
  end
end
