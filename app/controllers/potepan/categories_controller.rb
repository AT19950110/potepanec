class Potepan::CategoriesController < ApplicationController
  def show
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    @taxon = Spree::Taxon.find(params[:taxon_id])
    @products = Spree::Product.includes(master: [:images, :default_price]).in_taxon(@taxon)
  end
end
