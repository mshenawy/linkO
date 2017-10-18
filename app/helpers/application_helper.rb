module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "ﺕﺎﻜﻨﻴﻟ"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

 def link_to_in_li(body, url, html_options = {})
  active = "nav-link" if current_page?(url)
  content_tag :a, class: active do
    link_to body, url, html_options
  end
end

end
