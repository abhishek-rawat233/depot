module AdminHelper
  def get_category_parent(category)
    category.parent ? category.parent.name : 'no parent'
  end
end
