module ApplicationHelper
  def full_title(page_title)
    base_title = "BIGBAG Store"
    if page_title.empty?
      base_title
    else
      page_title + " - " + base_title
    end
  end

  def heading_title(page_heading)
    if page_heading.present? && page_heading.include?("/")
      page_heading.split("/")
    else
      heading_array = []
      heading_array.push(page_heading)
    end
  end
end
