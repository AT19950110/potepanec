require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "#show" do
    let(:product) { create(:product) }
    # 正常にレスポンスを返すこと
    it "responds successfully and 200 response" do
      get :show, params: {id: product.id}
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end
end
