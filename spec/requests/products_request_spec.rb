require 'rails_helper'

RSpec.describe "Products_request", type: :request do
  describe "GET #show" do
    let(:product) { create(:product) }

    # 正常にレスポンスを返すこと
    it "responds successfully and 200 response" do
      get potepan_product_url(product.id)
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end

    # 商品名のインスタンスメソッドが表示されていることを確認
    it "show templete instance display" do
      get potepan_product_url(product.id)
      expect(response.body).to include product.name
    end
  end
end
