Spree::Product.class_eval do
  scope :related_products_scope, ->(product) {
    in_taxons(product.taxons).
      where.not(id: product.id). # 引数で渡された商品は除く
      distinct.
      order(Arel.sql("RAND()")) # 毎回同じ関連商品を表示させない
  }
end
