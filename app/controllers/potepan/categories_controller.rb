class Potepan::CategoriesController < ApplicationController
  def show
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    @taxon = Spree::Taxon.find_by!(id: 1)
  end
end
