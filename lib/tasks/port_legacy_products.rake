namespace :port_legacy_products do
  desc "to set category_ids of products created before this point(Dec 9 2019, 12:24)"
  task :set_legacy_products_category => :environment do
    Product.all do |product|
      p product
      product.update(:category_id, Category.ids.first) if product.category_id?
    end
  end
end
