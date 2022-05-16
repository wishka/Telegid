module ApplicationHelper
  def full_title(page_title = '')
    base_title = "TelegaGid"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def current_user
    @current_user = @current_customer
  end
end
