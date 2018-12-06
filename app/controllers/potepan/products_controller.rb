class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.friendly.find(params[:id])
    @product_properties = @product.product_properties.includes(:property)
    @related_products = Spree::Product.related_products(@product)
  end
end
