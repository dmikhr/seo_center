module PagesHelper
  def show_item(caption, item)
    "#{caption}: #{item}" if item.present?
  end

  # show_collection(caption, collection)
  #   return if collection.empty?
  #   collection.each {  }
  # end
end
