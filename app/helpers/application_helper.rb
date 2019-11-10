module ApplicationHelper
  def websites_list_caption
    current_user.admin? ? 'Manage websites' : 'My websites'
  end
end
