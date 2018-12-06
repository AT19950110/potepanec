Spree::Product.class_eval do
  scope :related_products, ->(product) {
    in_taxons(product.taxons).
    includes(master: [:images, :default_price]).
    where.not(id: product.id).
    distinct.
    limit(4).
    order(Arel.sql("RAND()"))
  }
end
