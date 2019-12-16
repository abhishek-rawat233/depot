module StoreHelper
  def page_title
    @page_title
  end

  def set_image_data_attr(product)
    image_data_attr = {}
    product.images.each do |image|
      image_data_attr["image#{image.id}-id"] = image.image_url
    end
    image_data_attr
  end
end
