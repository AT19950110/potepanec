require 'rails_helper'

RSpec.describe "Products_request", type: :request do
  describe "GET #show" do
    let(:product) { create(:product) }
    let!(:product_property) { create(:product_property, product: product, value: "type") }

    # 正常にレスポンスを返すこと
    it "responds successfully and 200 response" do
      get potepan_product_url(product.id)
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end

    # 商品が表示されていることを確認
    it "show templete products display" do
      get potepan_product_url(product.id)
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
      expect(response.body).to include product_property.property.presentation
      expect(response.body).to include product_property.value
    end
  end
end
