class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.friendly.find(params[:id])
    @product_properties = @product.product_properties.includes(:property)
    @related_products = related_uniq_products_array(@product)
  end

  private

  # 関連した商品の配列を重複なしでランダムに取得する
  def related_uniq_products_array(product)
    related_array = []
    product.taxons.each do |taxon|
      related_array = taxon.products + related_array
    end
    related_array = related_array.uniq.shuffle
  end
end
