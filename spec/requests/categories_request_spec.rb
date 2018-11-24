require 'rails_helper'

RSpec.describe "Categories_request", type: :request do
  describe "GET categories#show" do
    let(:category) { create(:taxonomy, name: "Category") }
    let!(:bag) { create(:taxon, name: "Bag", taxonomy: category, parent: category.root) }
    let!(:rails_bags) { create(:product, taxons: [bag], name: "Ruby on Rails Bags") }

    before do
      get potepan_category_path(bag.id)
    end

    # 正常にレスポンスを返すこと
    it "responds successfully and 200 response" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
    # 正しいViewを返すこと
    it "show correct View" do
      expect(response).to render_template :show
    end
    # データが取得できていること
    it "assigns instance variables" do
      expect(assigns(:taxonomies)).to match_array category
      expect(assigns(:taxon)).to eq bag
      expect(assigns(:products)).to match_array rails_bags
    end
  end
end
