require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "#show" do
    before do
      @product = FactoryBot.create(:product)
    end
    # 正常にレスポンスを返すこと
    it "responds successfully" do
      get :show, params: {id: @product.id}
      expect(response).to be_successful
    end
    # 200レスポンスを返す
    it "returns a 200 response" do
      get :show, params: {id: @product.id}
      expect(response).to have_http_status "200"
    end
  end
end
