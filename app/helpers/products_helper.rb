module ProductsHelper
  # 引数で渡された商品に関連する商品をランダムに4件配列にして返す
  def related_uniq_products_array(product)
    related_array = []
    product.taxons.each do |taxon|
      related_array.concat(taxon.products)
    end
    related_array.delete_if { |item| item == product }
    related_array.uniq.shuffle[0..3]
  end
end
