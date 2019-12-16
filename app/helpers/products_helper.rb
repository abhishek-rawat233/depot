module ProductsHelper
  def set_images_path(images)
    image_path_collection = []
    images.each do |image|
      image_src_path = image.image_url
      image_path_collection << image_path(image_src_path) if asset_digest_path(image_src_path)
    end
    image_path_collection
  end
end
