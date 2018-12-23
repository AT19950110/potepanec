Spree::Product.class_eval do
  scope :related_products, ->(product, number) {
    in_taxons(product.taxons).
      where.not(id: product.id). # 引数で渡された商品は除く
      distinct.
      sample(number)
  }
end
