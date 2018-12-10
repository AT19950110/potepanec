class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.friendly.find(params[:id])
    @product_properties = @product.product_properties.includes(:property)
    @related_products = Spree::Product.includes(master: [:images, :default_price]).
      related_products_scope(@product).limit(4)
  end
end
