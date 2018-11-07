class Potepan::ProductsController < ApplicationController
  def index
    # 商品一覧ページを想定
  end

  def show
    @product = Spree::Product.friendly.find(params[:id])
    @product_properties = @product.product_properties.includes(:property)
  end
end
