module AdminHelper
  def get_parent_category(category)
    category.parent.try(:name) || 'no parent'
  end
end
