class Potepan::CategoriesController < ApplicationController
  def show
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    @taxon = Spree::Taxon.find_by(id: params[:id])
    @products = Spree::Product.includes(master: [:images, :default_price]).in_taxon(@taxon) #このスコープなに

    # @searcher = build_searcher(params.merge(taxon: 1, include_images: true))
    # @products = @searcher.retrieve_products
  end
end
